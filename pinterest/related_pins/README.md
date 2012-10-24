#### Goal: #### 
Write a function get_related_pins that takes a pin_id and returns a list of related pin_ids. Note that doing a good job on this challenge is as much about setting up good data structures and decomposing code cleanly as about clever data mining techniques, because setting up a good framework for iterating gets you further in the long run.

#### Data: #### 
board_json.txt and pin_json.txt are text files of JSON-encoded dictionaries of board and pin object data, respectively. There is data for ~300k pins and ~10k boards, with possible duplicates.

Each board JSON dict contains the fields id, user_id, username, name, slug, description, and category (which may be null, but if not, is one of a fixed set of categories). Each pin JSON dict contains the fields id, board_id, user_id, img_url, is_repin, is_video, source, and link.

To get the data into a format that is easy to work with, consider using a lightweight database system like SQLite. 

#### Extras: ####
* Can you make your algorithm fast enough to compute related pins on the fly?
* How can you filter out pins of the same / similar images from different sources?
* How can you extend your algorithm to consider more data, if it were available? For example, the number of repins and likes.

### Mina Doroudi's work ###

#### Github ####
https://github.com/mdoroudi/code/tree/master/pinterest/related_pins


Get the following packages to get this working:

```sh
$ sudo easy_install pip
$ sudo easy_install mysql-python
$ pip install storm
$ pip install python-levenshtein
```

#### How to run ####

run the following command and when it asks for the id enter a pin id
```sh
$ python get_related_pins.py
```


#### Solution ####

Libraries and Databases I'm using:
* Storm: ORM solution
* Levenshtein: Finding the Levenshtein distance between strings.
* MySQL

First load all the data into `pinterest_challenge` database, we have two tables: `baords` and `pins`

  `$ python load_data.py`

  this process loads all the pins into the pin table and boards into the board table. it avoid enterering duplicates in the table. 
  so from now on we don't have to worry about duplicates.
  this process loads data 10k at a time. The reason is othewise it has to read all the data at once and the memory would get full 
  and we run out of memory. Even though Boards are 10k in total I put the limit on those as well, in case we decide to have a lot of 
  boards.
  we also truncate all the tables before reinsurint the data, so anything in them would get lost.


Then we can run python get_related_pins.py and give it a pin and it'll give us back the top 100, related pins

  `$ python get_related_pins.py`

  this file is pretty much a wrapper around pin.py and baord.py
  it takes the pin_id from the user and gets all the related pins and return their total + the actual pin_ids
  Since I'm not too familiar with python I couldn't get to terminate cleanly if user enters a bad pin_id (string).
  
  the main files here are

  `board.py`

    this is the class wrapper around the database table boards. I used Storm to do that. Also we have a 
    many-to-one relationship from pins to boards. So each board has many pins and each pin has one Board.
    I had to specify that in get_related_pins.py, because otherwise I was getting circular import problems. 
    I'm sure there is a better way to do this, but I'm not too familiar with python.

    `same_category_boards_ids:`

      this method looks at the category versions of all hte boards in our db and return the one with the same category as self.

    `get_similar_boards:`

      this is the main class, to be used by pins.
      it gets all the boards in the same category, and for all of them look at their description, and create a levenshtein ratio for
      self.description over board.description. also if the boards don't have description it sets the levenshtein ratio as 0.
      then it sort them from highest to lowers levenshtein ratio and return them.

  `pin.py`

    this is the class wrapper around pins table. where each pin belongs to a board.
    
    `board():`
    
      this method return the board object for this pin
  
    `category:`

      retursn the category of the board I belong to

    `get_related_pins:`

      this is the main class
      for each pin the related pins are the pins in it's own board + pins coming from get_similar_boards above.
      then for all those pins, I check their source url and link and do a levenshtein ratio with the current pin.
      pretty much the same as boards, then sort them in the decreasing order. 
      I sort them based on source and then link ratio. 
      here I set the max_pins to be returned to be a 100 (MAX_RETURN_PINS) 

    `sort_pins_in_related_order:` 

      method used by get_related_pins, it takes in a list of pins and returns a list of 3-item tuples
      where the tuples are (source_ratio, link_ratio, pin_id) and then sort them based on the first and 
      second item in the tuple

    `get_pin_ids_in_related_order:`

      all this class does it, take a list of pins again, pass them to sort_pins_in_related_order and get
      the result, and from there get the pin_id only and put them in an array adn return it. 

#### EXTRA CREDIT SOLUTION ####

* Can you make your algorithm fast enough to compute related pins on the fly?
  
  we can use a caching server, for example Memcache to save the related pins.
  So to do that we can have a large cache for every category and cache new pins as they come in there.
  In pinterst the categories are set, so they are more clear than the categories in the json file.
  also under each category we can have their own subcategory and caceh based on that.
  for example we know the category is based on animal and if in the pin, or booard description or based on the url we can identify
  sometimes what kind of animal they are and then we can cache based on that. Ad people pin new items we cache them in their categories.
  and it's a LRU cache so any item that has not been pind recently as the cache gets full, it comes out of the cache.
  since we have a lot of data, we don't want ot search on mysql, we want to index everything in our cache servers and serve from there.

* How can you filter out pins of the same / similar images from different sources?
 
  first we can just look at the img_url, this usually gives us where it's been uploaded. so the imag can be embeded in multiple sites
  through a url so that is the easiest way to see if an image is exactly the same as the other.
  After that we can use image pattern matching. so if bits of the images in different areas are the same the images could be more similar

* How can you extend your algorithm to consider more data, if it were available? For example, the number of repins and likes.
  
  So first of all, I think the easiest way is, lets say pinterst usuall recommand 5 images when you pin an image. We want to make
  sure we recommand popular images so user clicks on them. So we can change our ranking to look at likes and repins and show those first.
  also everytime I pin something I get a new pin_id for that (at least that's what i see in teh site) so if we could see where the image is
  being repinned from we could also identify the same pins
  we could also lets say there are some really popular travel image sites or blugs (not flickr, maybe flick user) then when someone pins something
  from those sites or pin something that goes back to those sites from prev repins, we can pick the most popular pins based on likes and votes and
  recommand them to people

I hope you liked my code, I'm coming from a ruby background, so If part of my code doesn't look great for python, that is the reason why. 
This is pretty much my first real python program! :)


Mina Doroudi

10-23-2012


  
