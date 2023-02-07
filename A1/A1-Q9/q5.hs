import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable

createWavetable :: Float -> (Float -> Float) -> [Float]
createWavetable len fn =
 map (\x -> fn (2 * pi * x)) t
 where
  t = [0,1.0/(len + 1)..1]

process :: [Float] -> Int -> [Float]
process wavetable n =
 (concat $ take i $ repeat wavetable) ++ (take remain wavetable)
 where
  (i, remain) = n `divMod` n

main :: IO()
main = do
 let sound = createWavetable 44100.0 sin
 let output = process sound (44100 * 3)
 B.writeFile "out.bin" $ B.toLazyByteString $ fold $ map B.floatLE output
