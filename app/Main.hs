{-# LANGUAGE OverloadedStrings #-}
module Main where

import Lib


import Text.HTML.Scalpel

main :: IO ()
main = do
  let queryURL = "http://www.programcreek.com/java-api-examples/index.php?api=java.awt.geom.AffineTransform"
  res <- scrapeURL queryURL codeOnPage

  case res of
    Nothing -> print "Error in querying programcreek"
    Just codeblocks -> insertIntoDatabase queryURL codeblocks