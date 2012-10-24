from storm.locals import *
import Levenshtein
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

  def same_category_boards_ids(self):
    if self.category is None:
      return None
    else:
      return store.execute(Select(Board.id, Board.category == self.category)).get_all()


  # for all the board in the same category order them by Levenshtein ratio
  def get_similar_boards(self):
    ids = self.same_category_boards_ids()
    if ids is None:
      return None

    res = []
    for b_id in ids:
      curr_board = store.get(Board, b_id[0]) 
      curr_desc = curr_board.description or ''
      self_desc = self.description or ''
      if self_desc == '' or curr_desc ==  '': 
        ratio = 0 
      else:
        ratio = Levenshtein.ratio(self.description, curr_board.description) 
      res.append((ratio, curr_board))
    res.sort(key=lambda tup: tup[0], reverse=True)
    return res 

