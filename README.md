Parses program creek for code snippets

#Usage

To scrape program creek change the queryURL to parse in `app/Main.hs` then run the following from the command line:
```
$ stack build
$ stack exec program-creek-exe
```

To mess around with the resulting database:
```
$ sqlite3
> .open corpus.db
> select * from corpus;
...
```

#Requirements
 - [Haskell stack](https://docs.haskellstack.org/en/stable/README/)
 - Sqlite3
