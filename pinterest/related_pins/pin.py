from storm.locals import *
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
    store.get(board.Board, self.board_id)
