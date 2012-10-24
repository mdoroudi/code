from pin import Pin 
from board import Board
from storm.locals import *

database = create_database('mysql://root@/pinterest_challenge') 
store = Store(database)
Board.pins = ReferenceSet(Board.id, Pin.board_id)

def get_related_pins():
  pin_id = input("enter a pin id (integer): ")
  print "looking for related pins..."
  pin = store.get(Pin, pin_id)
  if pin is None: 
    print "Sorry! The pin_id '"+str(pin_id)+"' does not exist in our database, enter another pi_id."
  else:
    res = pin.get_related_pins()
    print "Found "+str(len(res))+" related pins!"
    print res 
get_related_pins()
