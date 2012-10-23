from storm.locals import *
import json
from board import Board
from pin import Pin 

# database setup
database = create_database('mysql://root@/pinterest_challenge') 
store = Store(database)

# If there is too much data we run out fo memory so everytime we read 
# MAX_INMEMORY ammoutn of data we have to write them to disk to continue
MAX_INMEMORY = 10000

# load only boards from file to db
def load_boards():
  boards_file = open('board_json.txt')
  boards = boards_file.readlines()
  insert_all_pins_or_boards(boards, "board")

# load only pins from file to db
def load_pins():
  pins_file = open('pin_json.txt')
  pins = pins_file.readlines()
  insert_all_pins_or_boards(pins, "pin")

# load all pins and baords to db
def load_all_data():
  load_boards()
  load_pins()

# save all the values in store to db and empty store
def store_to_db(store):
  store.commit()
  store.flush()

# helper function for a given set of json data of type pin or board insert them to db
def insert_all_pins_or_boards(all_data, class_name):
  counter = 0
  for index, item in enumerate(all_data):
    counter += 1
    data = json.loads(item)

    if class_name == "pin" :
      store.add(Pin(data))
    elif class_name == "board" :
      store.add(Board(data))

    if counter == MAX_INMEMORY :
      store_to_db(store)
      counter = 0
  store_to_db(store)


load_all_data()
