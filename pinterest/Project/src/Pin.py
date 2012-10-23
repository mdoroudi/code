'''
Created on Jun 9, 2012

Pin module contains all the implementations related to Pin

@author: vivianxu
'''
from Database import Database
from Board import Board
from Correlation import CorCache, CorCalc


class Pin(object):
    '''
    Pin class implements interfaces for Pin related operations
    '''
    
    TABLE_NAME = "pin_table"
    JSON_FILE_NAME = "..\\data\\pin_json.txt"

    # database connection  
    db = []
    
    # attribute definition for Pin object
    attr_def = {'board_id' : 'INTEGER',
             'user_id' : 'INTEGER',
             'img_url' : 'TEXT',
             'is_repin' : 'TEXT',
             'source' : 'TEXT',
             'link' : 'TEXT',
             'details' : 'BLOB',
             'is_video' : 'TEXT',
             'id' : 'INTEGER PRIMARY KEY'}
    
    # Correlation weights for different attributes
    # This should be fine tuned or configurable
    cor_weight = {"same_user": 10,
                  "same_is_video": 5,
                  "similar_details": 50,
                  "similar_source": 15,
                  "similar_link": 10,
                  "similar_board": 20}

    # Sum of all the weights for normalizing correlation ratio
    cor_weight_total = sum(cor_weight.values())
    
    # Penalty for repin 
    repin_penalty = -0.05
    
    # Caches the correlation we have calculated for pairs of pins
    cor_cache = CorCache()


    def __init__(self, pin_data):
        '''
        Constructor
        '''
        # Unpack pin data based on the definition of Pin object
        pin_dict = dict(Pin.attr_def)
        for key in Pin.attr_def.keys():
            try:
                pin_dict[key] = pin_data[key]
            except:
                print "Fail to construct for key " + key
                raise
        self.__dict__ = pin_dict
        
        # Query the database to get the board of the pin
        self._board = Board.get_by_id(self.board_id)
        self.related_pins = {}

            
    @property
    def board(self):
        return self._board
    

    @board.setter
    def board(self, board):
        self._board = board
         
    
    @staticmethod
    def create_table():
        Pin.db.drop_table(Pin.TABLE_NAME)
        Pin.db.create_table(Pin.TABLE_NAME, Pin.attr_def)
        Pin.db.update_table(Pin.TABLE_NAME, Pin.JSON_FILE_NAME)
        
    
    @staticmethod    
    def get(key, value):
        pin_result = []
        try:
            # Query the database to get rows where key = value
            result = Pin.db.get_rows(Pin.TABLE_NAME, key, value)
        except:
            print "Fail to get pins for " + key + " = " + str(value)
            raise  
             
        for p in result:
            pin_result.append(Pin(p))
            
        return pin_result
    
    
    @staticmethod    
    def get_by_id(pin_id):
        try:
            return Pin.get("id", pin_id)[0]
        except:
            return []
        

    @staticmethod
    def get_by_board_id(board_id):
        return Pin.get("board_id", board_id)    
            
    
    @staticmethod
    def get_by_user_id(user_id):
        return Pin.get("user_id", user_id)   
    
    
    @staticmethod
    def get_by_category(category):
        query = "SELECT * FROM " + Pin.TABLE_NAME + " p\
                INNER JOIN \
                (SELECT * FROM " + Board.TABLE_NAME + " \
                    WHERE category = ?) b\
                WHERE p.board_id = b.id"

        parameters = (category,)
        pin_result = []
        
        try:
            result = Pin.db.fetchall(query, parameters)
        except:
            print "Fail to get pins for category = " + category
            raise  
             
        for p in result:
            pin_result.append(Pin(p))
            
        return pin_result
    
      
    @staticmethod
    def get_correlation_by_id(id1, id2):
        '''
        Get the correlation for two pins with id1 and id2.
        It queries the cache first, and if missing the cache, it queries the
        database and re-caculate the correlation
        The correlation is normalized to [0,1] and same pins (i.e. same id)
        have correlation 1.0
        '''    
        if id1 == id2:
            cor = 1.0
        else:      
            if Pin.cor_cache.has(id1, id2):
                cor = Pin.cor_cache.get(id1, id2)
            else:
                pin1 = Pin.get_by_id(id1)
                pin2 = Pin.get_by_id(id2)
                
                cor = Pin.cal_correlation(pin1, pin2)
        return cor
    
    
    @staticmethod
    def get_correlation(pin1, pin2):
        '''
        Get the correlation for two pins, pin1 and pin2. 
        It queries the cache first, and if missing the cache, it re-caculates
        the correlation.
        The correlation is normalized to [0,1] and same pins (i.e. same id)
        have correlation 1.0
        '''    
        if pin1.id == pin2.id:
            cor = 1.0
        else:
            if Pin.cor_cache.has(pin1.id, pin2.id):
                cor = Pin.cor_cache.get(pin1.id, pin2.id)
            else:
                cor = Pin.cal_correlation(pin1, pin2)

        return cor
    
    

    @staticmethod
    def cal_correlation(pin1, pin2):
        '''
        Calculate the correlation for two pins, pin1 and pin2.
        It looks at the similarity of each attributes and sum them up with 
        different weights. 
        The correlation is normalized to [0,1] and same pins (i.e. same id)
        have correlation 1.0
        ''' 
        cor = (
            int(pin1.user_id == pin2.user_id) * Pin.cor_weight["same_user"] + 
            int(pin1.is_video == pin2.is_video) * Pin.cor_weight["same_is_video"] +
            CorCalc.get_correlation_str(pin1.details, pin2.details) * Pin.cor_weight["similar_details"] + 
            CorCalc.get_correlation_url(pin1.source, pin2.source) * Pin.cor_weight["similar_source"] +
            CorCalc.get_correlation_url(pin1.link, pin2.link) * Pin.cor_weight["similar_link"] +
            Board.get_correlation(pin1.board_id, pin2.board_id) * Pin.cor_weight["similar_board"]
            ) / Pin.cor_weight_total

        Pin.cor_cache.update(pin1.id, pin2.id, cor)
        return cor
    
    
    def update_related_pin(self):
        '''
        Update related pins and the correlations. It retrieves pins of the same
        user and pins from the boards of the same category. 
        ''' 
        pins_same_user = Pin.get_by_user_id(self.user_id)
        pins_same_category = Pin.get_by_category(self.board.category)
        
        related_pins = pins_same_user + pins_same_category
        for p in related_pins:
            # No need to store itself as related pins
            if p.id != self.id:
                cor = Pin.get_correlation(self, p) + int(p.is_repin) * Pin.repin_penalty
                self.related_pins[p.id] = cor
                
            
    def get_related_pins(self, size):
        '''
        Get the top 'size' number of related pins, sorted in correlation ratio 
        '''
        related_pins = sorted(self.related_pins.iteritems(), key=lambda x: x[1], reverse = True)
        return related_pins[:size]