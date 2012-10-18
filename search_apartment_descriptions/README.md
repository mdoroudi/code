### Snippet generator

A program that generate description snippets given an apartment description and a search query. 
It returns nothing if there are no snippets matching the search query.

by default there is an apartment description in `descriptions.txt` but if you like to have your own description, overwrite the content of the file with your description in one line.
rake command would give you instruction if you don't pass it anything or if the query or the file is empty.

#### How to run:
```sh
$ rake search:snippets query=keywords+seperated+by+plus`
```

#### examples:
```sh
$ rake search:snippets query=kitchen
$ rake search:snippets query=designer+kitchen
$ rake
```
