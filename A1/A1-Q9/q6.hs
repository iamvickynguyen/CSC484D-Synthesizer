import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable
import Data.List

createWavetable :: Float -> Float -> (Float -> Float) -> [Float]
createWavetable len f fn =
 map (\x -> fn (2 * pi * f * x)) t
 where
  t = [0,1.0/(len + 1)..1]

process :: [Float] -> Int -> [Float]
process wavetable n =
 (concat $ take i $ repeat wavetable) ++ (take remain wavetable)
 where
  (i, remain) = n `divMod` n

main :: IO()
main = do
 let tables = map (\f -> createWavetable 44100.0 f sin) [200.0, 660.0]
 let voices = map (\wave -> process wave (64 * 3)) tables
 let output = map (\l -> sum l) $ transpose voices
 B.writeFile "out.bin" $ B.toLazyByteString $ fold $ map B.floatLE output
