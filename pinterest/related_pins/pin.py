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
  MAX_RETURN_PINS = 100

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
  
  # takes in list of pin objects
  # return list of pin ids sorted
  def get_pin_ids_in_related_order(self, pins):
    pin_tuples = self.sort_pins_in_related_order(pins)
    res = []
    for tup in pin_tuples:
      res.append(tup[2])
    return res

  # takes in a list of pin objects 
  # returns list of (source_ration, link_ratio, pin.id) tuples
  def sort_pins_in_related_order(self, pins):
    res = []
    for pin in pins:
      source_ratio = self.levenshtein_ratio(self.source, pin.source)
      link_ratio = self.levenshtein_ratio(self.link, pin.link)
      res.append((source_ratio, link_ratio, pin.id))

    sorted(res, key=lambda tup: (tup[0], tup[1]))
    return res 


  # main function
  def get_related_pins(self):
    similar_boards = self.board().get_similar_boards()
    sbl_pins = self.sibling_pins()
    if similar_boards is None:
      return self.get_pin_ids_in_related_order(sbl_pins)[:self.MAX_RETURN_PINS] 
    else:
      top_similar_boards = similar_boards[:self.MAX_SIMILAR_BAORDS]
      res = []
      for brd in top_similar_boards:
        for pn in brd[1].pins:
          res.append(pn)
  
    return self.get_pin_ids_in_related_order(res)[:self.MAX_RETURN_PINS]

  def levenshtein_ratio(self, str1, str2):
    if str1 is None or str1 == '' or str2 is None or str2 == '':
      return 0
    else:
      return Levenshtein.ratio(str1, str2)
