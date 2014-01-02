import Data.List (genericLength, subsequences, permutations)
import Control.Monad (liftM2)
import Data.Ord (comparing)

data Description a = Description
    { minPos :: a
    , startPos :: a
    , maxPos :: a
    , rotations :: [a]
    } deriving (Show)

data Outcome a = Outcome
    { minSol :: [[a]]
    , maxSol :: [[a]]
    } deriving (Show)

isSolution :: Real a => Description a -> [a] -> Bool
isSolution d candidate = withinBounds && atEnd
    where
        steps = scanl (step d) (startPos d) candidate
        withinBounds = all (liftM2 (&&) (minPos d <=) (<= maxPos d)) candidate
        atEnd = last steps == maxPos d

step :: Real a => Description a -> a -> a -> a
step d x y
    | s < minPos d = minPos d
    | otherwise = s
    where
        s = x + y

enumerate :: Real a => Description a -> [[a]]
enumerate = concatMap permutations . subsequences . rotations

solutions :: Real a => Description a -> [[a]]
solutions = liftM2 filter isSolution enumerate

getOutcome :: Real a => Description a -> Maybe (Outcome a)
getOutcome d
    | solvable = Just $ Outcome smallestSols largestSols
    | otherwise = Nothing
    where
        allSolutions = solutions d
        solvable = not . null $ allSolutions
        smallestSols = minimumsBy (comparing genericLength) allSolutions
        largestSols = maximumsBy (comparing genericLength) allSolutions

maximumsBy :: Ord a => (a -> a -> Ordering) -> [a] -> [a]
maximumsBy _ [] = []
maximumsBy cmp xs = foldl maxBy [] xs
    where
        maxBy [] b = [b]
        maxBy as@(a:_) b = case cmp a b of
                        LT -> [b]
                        EQ -> b:as
                        GT -> as

minimumsBy :: Ord a => (a -> a -> Ordering) -> [a] -> [a]
minimumsBy cmp = maximumsBy (negateOrdering .* cmp)

negateOrdering :: Ordering -> Ordering
negateOrdering LT = GT
negateOrdering EQ = EQ
negateOrdering GT = LT

infixr 9 .*
(.*) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(.*) = (.) . (.)

test :: (Show a, Real a) => Description a -> IO ()
test d = do
    print d
    print $ getOutcome d
    putStrLn ""

main :: IO ()
main = do
    test $ Description 0 0 6 [-1, 0, 1, 2, 3, 4, 5, 6]
    test $ Description 0 6 7 [7, 7, 5, 3, 8, 9, 0]
