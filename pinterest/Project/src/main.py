'''
Created on Jun 9, 2012

@author: vivianxu
'''
from Database import Database
from Pin import Pin
from Board import Board

db_name = "pinterest"
MAX_RELATED_PINS = 200

def get_related_pins(pin_id):
    '''
    Get a list of related pins for the pin with pin_id.
    '''
    
    pin = Pin.get_by_id(pin_id)
    pin.update_related_pin()
    
    result = pin.get_related_pins(MAX_RELATED_PINS)
        
    print "The top " + str(len(result)) + " related pins for pin " + str(pin_id)
    for r in result:
        print "id = " + str(r[0]) + ", correlation = " + str(r[1])
        
    return result

    
if __name__ == '__main__':  

    
    db = Database(db_name)
    
    # Connect database and create tables
    Pin.db = db
    Pin.create_table()
    Board.db = db
    Board.create_table()
    
    pin_id = "167055467397417943"

    result = get_related_pins(pin_id)

