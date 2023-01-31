import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable

generateSound :: Int -> Float -> [Float]
generateSound note duration =
 map (\x -> sin(2 * pi * freq * t))
 where
  freq = 440
  srate = 44100
  f = (1.0 * freq/32) * (2 ** ((note - 9.0)/12))
  t = [0,1.0/srate..ceiling(duration)]

main :: IO()
main = do
 contents <- getContents
 let notes = map (\x y -> [(read :: String -> Int) x, (read :: String -> Float) y])$ lines contents
-- B.writeFile "out.bin" $ B.toLazyByteString $ fold $ map B.floatLE sinewave
 map putStrLn $ map (\x y -> x ++ " " ++ y) notes
