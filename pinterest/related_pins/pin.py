from storm.locals import *
import Levenshtein
import board
database = create_database('mysql://root@/pinterest_challenge') 
store = Store(database)

class Pin(object):
  __storm_table__ = 'pins'
  id = Int(primary=True)
  field_id = Int()
  board_id = Int()
  user_id = Int()
  img_url = Unicode()
  is_repin = Int()
  is_video = Int()
  source = Unicode()
  link = Unicode()
  MAX_SIMILAR_BAORDS = 50

  def __init__(self, val): 
    self.id = val['id']
    self.board_id = val['board_id']
    self.user_id = val['user_id']
    self.img_url = val['img_url']
    self.is_repin = val['is_repin']
    self.is_video = val['is_video']
    self.source = val['source']
    self.link = val['link']

  def board(self):
    return store.get(board.Board, self.board_id)

  # category of the current board which becomes the pins category
  def category(self):
    return self.board().category

  # other pins in the same board as the current pin
  def sibling_pins(self):
    return self.board().pins 
  
  def same_category_pins(self):
    similar_baords = self.board().get_similar_baords()
    sibling_pins = self.sibling_pins()

    if similar_boards is Node:
      return sibling_pins
    else
      top_similar_boards = similar_boards[:MAX_SIMILAR_BAORDS]

  def get_related_pins(self):
    

