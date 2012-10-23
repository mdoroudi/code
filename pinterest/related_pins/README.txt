Goal: 
Write a function get_related_pins that takes a pin_id and returns a list of related pin_ids. Note that doing a good job on this challenge is as much about setting up good data structures and decomposing code cleanly as about clever data mining techniques, because setting up a good framework for iterating gets you further in the long run.

Data: 
board_json.txt and pin_json.txt are text files of JSON-encoded dictionaries of board and pin object data, respectively. There is data for ~300k pins and ~10k boards, with possible duplicates.

Each board JSON dict contains the fields id, user_id, username, name, slug, description, and category (which may be null, but if not, is one of a fixed set of categories). Each pin JSON dict contains the fields id, board_id, user_id, img_url, is_repin, is_video, source, and link.

To get the data into a format that is easy to work with, consider using a lightweight database system like SQLite. 

Extras:
- Can you make your algorithm fast enough to compute related pins on the fly?
- How can you filter out pins of the same / similar images from different sources?
- How can you extend your algorithm to consider more data, if it were available? For example, the number of repins and likes.


Get the following packages to get this working:

sudo easy_install pip
sudo easy_install mysql-python
pip install storm
pip install python-levenshtein

