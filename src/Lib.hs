{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( 
        codeOnPage, 
        classURLs,
        insertIntoDatabase
    ) where

import Text.HTML.Scalpel
import Database.SQLite.Simple

{- Scraping Part -}

-- A scraper that will find all the 
-- pre tags with the class pretty print
-- and collect the text of each into a string
-- and thus return a list of strings
codeOnPage :: Scraper String [String]
codeOnPage = texts ("pre"  @: [hasClass "prettyprint"])


-- A scraper that will find all the 
-- anchor tags that are nested within li elements
-- and take their URLS
classURLs :: Scraper String [String]
classURLs = chroots ("li" // "a") $ do 
  href <- attr "href" anySelector
  return href

{- Database Part -}

-- This code will take a URL (string) and a list of code-blocks (list of strings)
-- and insert it into a sqlite3 database
insertIntoDatabase :: String -> [String] -> IO ()
insertIntoDatabase queryURL codeblocks = do
      -- Open connection to database
      conn <- open "corpus.db"

      -- Insert each URL/code block combination into database 
      mapM_ (execute conn "INSERT INTO corpus (url, code) VALUES (?, ?)") entries
      putStrLn ("Number of code-blocks inserted into database: " ++ (show (length entries)))
      
      --close connection 
      close conn

      where 
        --connects each codeblock with the URL it came from
        entries :: [(String, String)]
        entries = zip (repeat queryURL) codeblocks

