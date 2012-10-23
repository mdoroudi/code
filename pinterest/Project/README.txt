
========================PROBLEM=================================
Goal: 
Write a function get_related_pins that takes a pin_id and returns a list of related pin_ids. Note that doing a good job on this challenge is as much about setting up good data structures and decomposing code cleanly as about clever data mining techniques, because setting up a good framework for iterating gets you further in the long run.


Data: 
board_json.txt and pin_json.txt are text files of JSON-encoded dictionaries of board and pin object data, respectively. There is data for ~300k pins and ~10k boards, with possible duplicates.
Each board JSON dict contains the fields id, user_id, username, name, slug, description, and category (which may be null, but if not, is one of a fixed set of categories). 
Each pin JSON dict contains the fields id, board_id, user_id, img_url, is_repin, is_video, source, and link.
To get the data into a format that is easy to work with, consider using a lightweight database system like SQLite. 


Extras:
- Can you make your algorithm fast enough to compute related pins on the fly?
- How can you filter out pins of the same / similar images from different sources?
- How can you extend your algorithm to consider more data, if it were available? For example, the number of repins and likes.


===========================SOLUTION==============================

Development Environment: Eclipse 3.7.2 with DyDev 2.5.0


High Level Workflow:

For the queried pin:
- Retrieve all the pins from the same user (including pins from the same board) and from the boards of same category, as potential related pins
- Calculate correlations between this pin and the potential related pins
- Sort the related pins based on the correlations and return the top certain number of related pins


Correlation Definition:

Each pair of boards has a correlation ratio, which represents how much they are related to each other. The correlation of two boards is weighted sum of similarities of their attributes, including its user, description, slug and name. The correlation is normalized to [0,1], where the same board (i.e. same board id) have the correlation 1. (See Board module)

Similarly, each pair of pins has a correlation ratio, which is also weighted sum of similarities of their attributes, including its user, is video, details, source, link and board. (The similarity of two pins’ boards is defined as the correlation ratio for boards above.) As the original pins might be more interesting, a small penalty is applied for pins if they are re-pined. (See Pin module)

Due to time constraint, the similarity of text attributes is simply calculated using the built-in python method, SequenceMatcher. For attributes like description and details, some trivial words (e.g. “is”, “a”, “I”) are eliminated from the string for the comparison. (See CorCalc class in Correlation module)
 

Other Implementation Details:

As the correlations for pairs of pins or boards are calculated, they are cached for easier retrieving later. The key is the pair of ids and cached value is the correlation. (See CorCache class in Correlation module)

SQLite is used as the database system. (See Database module)


Potential Improvement:

- Not only considering the boards of same category, also boards with high correlations
- A more sophisticated algorithm for calculating the similarity of descriptions and details. A potential approach is to extract key words for each pin’s data and compare the key word lists.
- Correlation weights for different attributes should be fine-tuned. They could even be dynamic for different users or configurable for searching or ranking purpose.


Answers to Extras questions:

- Can you make your algorithm fast enough to compute related pins on the fly?
A good cache mechanism can dramatically save the computation cost. The current implementation has adopted some cache technic for performance improvement. We could also cache related pins for each pin and only update them periodically or when it is necessary.

- Can you filter out pins of the same / similar images from different sources?
We can use image comparison algorithm to extract correlation ratio for pairs of pin images, and then apply penalty based on the correlation of pins images or simply eliminate the ones if their image correlation exceeds certain threshold.
Built-in python image library (PIL) can be used here. To deal with the problem of different sizes, we can resample images to the same smaller size and compare resampled images. This method can eliminate some noise. Another interesting and simple solution was discussed online is to encode the image as a jpeg and look for a substantial change in file size. 
Image comparison could be a very complicated problem itself. But for the purpose of this project, I think an easy approach should be taken and accuracy has less importance.

- How can you extend your algorithm to consider more data, if it were available? For example, the number of repins and likes.
Yes. My algorithm can easily be extended to consider more data. We can add bonus to the correlation based on the number of repins and likes, just like what current algorithm does for re-pined pins but the opposite.

