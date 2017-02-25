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

scrapeAPI :: String -> IO()
scrapeAPI api = do
  res <- scrapeURL api classURLs
  case res of
    Nothing -> putStrLn "Yikes"
    Just urls -> mapM_ scrapeClass urls 

apis :: [String]
apis = ["http://www.programcreek.com/java-api-examples/?ClassName=java.awt.geom&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=org.joda.time&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=org.apache.commons.math3&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=org.apache.commons.math&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=com.opengamma.analytics.math&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=org.w3c.dom&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=javax.xml&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=org.xml.sax&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=javax.swing.text&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=org.apache.http&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=org.apache.commons.io&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=java.net.URI&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=com.mashape.unirest&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=com.jcabi.http&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=Hirondelle.date4j&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=java.nio&submit=Search",  "http://www.programcreek.com/java-api-examples/?ClassName=java.io"]

main :: IO ()
main = do
  mapM_ scrapeAPI apis
  print "Successfully scraped apis"
