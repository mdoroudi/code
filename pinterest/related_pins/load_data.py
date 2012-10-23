from storm.locals import *
import json
from board import Board
from pin import Pin 

database = create_database('mysql://root@/pinterest_challenge') 
store = Store(database)

boards_file = open('board_json.txt')
boards = boards_file.readlines()

data = json.loads(boards[0])
store.add(Board(data))
store.commit()

for board in boards:
	data = json.loads(board)
	store.add(Board(data))
store.commit()
store.flush()

pins_fiele = open('pin_json.txt')
pins = pins_fiele.readlines()
for pin in pins:
	data = json.load(pin)
	store.add(Pin(data))

store.commit()
store.flush()
