from pin import Pin 
from storm.locals import *



def get_related_pins():
  pin_id = input("enter a pin id: ")
  print "looking for related pins..."
  database = create_database('mysql://root@/pinterest_challenge') 
  store = Store(database)
  pin = store.get(Pin, pin_id)
  if pin is None: 
    print "Sorry! The pin_id '"+str(pin_id)+"' does not exist in our database, enter another pi_id."
  else:
    print pin.get_related_pins()

get_related_pins()
