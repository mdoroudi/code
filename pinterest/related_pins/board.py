from storm.locals import *
import pin
database = create_database('mysql://root@/pinterest_challenge') 
store = Store(database)

class Board(object):
  __storm_table__ = 'boards'

  id = Int(primary=True)
  field_id = Int()
  user_id = Int()
  username = Unicode()
  name = Unicode()
  slug = Unicode()
  description = Unicode()
  category = Unicode()

  def __init__(self, val): 
    self.id = val['id']
    self.user_id = val['user_id']
    self.username = val['username']
    self.name = val['name']
    self.slug = val['slug']
    self.description = val['description']
    self.category = val['category']
    
Board.pins = ReferenceSet(Board.id, pin.Pin.board_id)
