class Pin:
  __storm_table__ 'pins' 
  id = Int(primary=True)
  field_id = Int()
  board_id = Int()
  user_id = Int()
  img_url = Int()
  is_repin = Int()
  is_video = Int()
  source = Int()
  link = Int()
