'''
Created on Jun 9, 2012

Board module contains all the implementations related to Board

@author: vivianxu
'''

from Database import *
from Correlation import CorCache, CorCalc

class Board(object):
    '''
    Board class implements interfaces for Board related operations
    '''
    
    TABLE_NAME = "board_table"
    JSON_FILE_NAME = "..\\data\\board_json.txt"

    # database
    db = []
    
    # attribute definition for Pin object
    attr_def = {'username': 'TEXT',
                'category': 'TEXT',
                'user_id': 'INTEGER',
                'description': "BLOB",
                'slug': 'TEXT',
                'id': 'INTEGER PRIMARY KEY',
                'name': 'Ideas'}
    
    
    # Correlation weights for different attributes
    # This should be fine tuned or configurable
    cor_weight = {"same_user" : 10,
                  "same_category": 10,
                  "similar_description": 50,
                  "similar_slug": 15,
                  "similar_name": 15}
    
    # Sum of all the weights for normalizing correlation ratio
    cor_weight_total = sum(cor_weight.values())
    
    # Caches the correlation we have calculated for pairs of boards
    cor_cache = CorCache()
    
    
    def __init__(self, board_data):
        '''
        Constructor
        '''
        # Unpack board data based on the definition of Board object
        board_dict = dict(Board.attr_def)    
        for key in board_dict.keys():
            try:
                board_dict[key] = board_data[key]
            except:
                print "Fail to construct for key " + key
                raise
            
        self.__dict__ = board_dict
        self.related_boards = {}
        
        
    @staticmethod
    def create_table():
        Board.db.drop_table(Board.TABLE_NAME)
        Board.db.create_table(Board.TABLE_NAME, Board.attr_def)
        Board.db.update_table(Board.TABLE_NAME, Board.JSON_FILE_NAME)
        
        
    @staticmethod    
    def get(key, value):    
        board_result = []
        try:
            result = Board.db.get_rows(Board.TABLE_NAME, key, value)
        except:
            print "Fail to get board(s) for " + key + " = " + str(value)
            raise  
             
        for b in result:
            board_result.append(Board(b))
            
        return board_result
    
    
    @staticmethod    
    def get_by_id(board_id):
        
        try:
            return Board.get("id", board_id)[0]
        except:
            return []
    
    
    @staticmethod    
    def get_by_user(user_id):
        return Board.get("user_id", user_id)
    
    
    @staticmethod    
    def get_by_category(category):
        return Board.get("category", "\"" + category + "\"")
    
    
    @staticmethod
    def get_correlation(id1, id2):
        '''
        Get the correlation for two boards with id1 and id2.
        It queries the cache first, and if missing the cache, it queries the
        database and re-caculate the correlation
        The correlation is normalized to [0,1], where same board (i.e. same id)
        have correlation 1.0
        '''  
        if id1 == id2:
            cor = 1.0
        else:
            
            if Board.cor_cache.has(id1, id2):
                cor = Board.cor_cache.get(id1, id2)
            else:
                board1 = Board.get_by_id(id1)
                board2 = Board.get_by_id(id2)
                
                cor = (
                    int(board1.user_id == board2.user_id) * Board.cor_weight["same_user"] + 
                    CorCalc.get_correlation_str(board1.description, board2.description) * Board.cor_weight["similar_description"] + 
                    CorCalc.get_correlation_str(board1.slug, board2.slug) * Board.cor_weight["similar_slug"] +
                    CorCalc.get_correlation_str(board1.name, board2.name) * Board.cor_weight["similar_name"]
                    ) / Board.cor_weight_total
    
                Board.cor_cache.update(board1.id, board2.id, cor)
            
        return cor
    
    
    def update_related_boards(self):
        '''
        Update related boards and the correlations. For simplicity, it only
        retrieves boards of the same the same category. 
        ''' 
        same_category = Board.get_by_category(self.category)
        print str(len(same_category)) + " boards with same category"
        for b in same_category:
            # No need to store itself as related board
            if self.id != b.id:
                cor = Board.get_correlation(self.id, b.id)
                self.related_boards[b.id] = cor
       
    
    def get_related_boards(self, size):
        '''
        Get the top 'size' number of related boards, sorted in correlation ratio 
        '''
        related_boards = sorted(self.related_boards.iteritems(), key=lambda x: x[1], reverse = True)
        print str(len(related_boards)) + " related boards"
        return related_boards[:size]
            
            
