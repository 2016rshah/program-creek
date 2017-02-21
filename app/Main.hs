{-# LANGUAGE OverloadedStrings #-}
module Main where

import Lib

import Text.HTML.Scalpel

scrapeClass :: String -> IO()
scrapeClass queryURL = do  
  res <- scrapeURL queryURL codeOnPage
  case res of
    Nothing -> putStrLn "Error in querying program-creek for this URL"
    Just codeblocks -> insertIntoDatabase queryURL codeblocks

main :: IO ()
main = do
  let api = "http://www.programcreek.com/java-api-examples/?ClassName=java.awt.geom&submit=Search"
  res <- scrapeURL api classURLs
  case res of
    Nothing -> putStrLn "Yikes"
    Just urls -> mapM_ scrapeClass urls 
  -- "http://www.programcreek.com/java-api-examples/?ClassName=java.awt.geom&submit=Search"
  -- print res 