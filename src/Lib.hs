{-# LANGUAGE OverloadedStrings #-}

module Lib (main) where

import           Data.Text       (pack, unpack)
import           Filesystem.Path (replaceExtension)
import           Prelude         hiding (FilePath)
import           Turtle

parser :: Parser FilePath
parser = argPath "diaFile" "The dia file"

createTmpFile :: Shell (FilePath, Handle)
createTmpFile = do
  tempdir <- using (mktempdir "/tmp" "dia2pdf")
  using (mktemp tempdir "tmp")

testFileExist :: FilePath -> IO ()
testFileExist a = do
  b <- testfile a
  unless b $ die $ format fp a <> " does not exist"

main :: IO ()
main = sh (do
  argPath <- options "dia2svg" parser
  (tmp, _) <- createTmpFile
  argPathExist <- liftIO $ testfile argPath
  liftIO $ do
    testFileExist argPath
    putStrLn $ unpack ("Processing " <>  format fp argPath)
    shell ("dia " <> format fp argPath <> " -e " <> format fp tmp <> " -t svg") empty
    testFileExist tmp
    let pdfFile = replaceExtension argPath "pdf"
    shell ("inkscape --without-gui --export-pdf=" <> format fp pdfFile <> " --export-area-drawing " <> format fp argPath) empty
    testFileExist pdfFile
  )
