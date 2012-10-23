class Board:
  __storm_table__ 'boards'
  id = Int(primary=True)
  field_id = Int()
  user_id = Int()
  username = Unicode()
  name = Unicode()
  slug = Unicode()
  description = Unicode()
  category = Unicode()
