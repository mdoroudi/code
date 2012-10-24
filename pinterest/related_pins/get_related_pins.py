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
    print pin.get_related_pins()
    print pin.board()
    print pin.category()
    print pin.sibling_pins().count()

get_related_pins()

#class PinsAndBoards(object):

  ########################### BOARD RELATED METHODS #########################

  #Board.pins = ReferenceSet(Board.id, Pin.board_id)
  
  ##def same_category_boards_ids(brd):
    ##if brd.category is None:
      ##return None
    ##else:
      ##return store.execute(Select(Board.id, Board.category == brd.category)).get_all()

  ### for all the board in the same category order them by Levenshtein ratio
  ##def get_similar_baords(brd):
    ##ids = brd.same_category_boards_ids()
    ##if ids is None:
      ##return None

    ##res = []
    ##for b_id in ids:
      ##curr_board = store.get(Board, b_id) 
      ##ratio = Levenshtein.ratio(brd.description, curr_board.description) 
      ##res.append((ratio, curr_board))
    ##return res.sort(key=lambda tup: tup[0], reverse=True)

  ########################### PINS RELATED METHODS #########################
   
  #def pins_board(pn):
    #return store.get(Board, pn.board_id)

  ### category of the current board which becomes the pins category
  ##def pin_category(self):
    ##return self.pins_board().category

  ### other pins in the same board as the current pin
  ##def sibling_pins(self):
    ##return self.pins_board().pins() 
  
  ### takes in list of pin objects
  ### return list of pin ids sorted
  ##def get_pin_ids_in_related_order(self, pins):
    ##pin_tuples = sort_pins_in_related_order(self, pins)
    ##res = []
    ##for tup in pin_tuples:
      ##res.append(tup[0])
    ##return res

  ### takes in a list of pin objects 
  ### returns list of (source_ration, link_ratio, pin.id) tuples
  ##def sort_pins_in_related_order(self, pins):
    ##res = []
    ##for pin in pins:
      ##source_ratio = Levenshtein.ratio(self.source, pin.source)
      ##link_ratio = Levenshtein.ratio(self.link, pin.link)
      ##res.append((source_ratio, link_ratio, pin.id))

    ##res.sort(key=lambda tup: tup[0], reverse=True)   
    ##return res 


  ##def get_related_pins(self):
    ##similar_baords = self.pins_board().get_similar_baords()
    ##sibling_pins = self.sibling_pins()

    ##if similar_boards is Node:
      ##return get_pin_ids_in_related_order(sibling_pins)[:MAX_RETURN_PINS] 
    ##else:
      ##top_similar_boards = similar_boards[:MAX_SIMILAR_BAORDS]
      ##res = []
      ##for baord in top_similar_boards:
        ##pins = board[1].pins()
        ##res.append(sort_pins_in_related_order(pins)) 

    ##res.sort(key=lambda tup: tup[0], reverse=True)   
    ##return get_pin_ids_in_related_order(res)[:MAX_RETURN_PINS]

