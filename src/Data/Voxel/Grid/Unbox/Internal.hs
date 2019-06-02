module Data.Voxel.Grid.Unbox.Internal where

import Control.Monad.Primitive (PrimMonad, PrimState)
import Control.Monad.ST
import Data.Vector.Unboxed (Unbox, Vector)
import Data.Voxel.Grid.Unbox.Mutable.Internal (MVoxelGrid)
import Linear

import qualified Data.Vector.Unboxed as V
import qualified Data.Vector.Unboxed.Mutable as VM
import qualified Data.Voxel.Grid.Unbox.Mutable.Internal as GM

-- | Immutable square 3D grid of unboxed data.
--
-- Effectively it is fixed size wrapper around `Vector`.
data VoxelGrid a = VoxelGrid {
  -- | Size of one dimension
    voxelGridSize :: !Int
  -- | Vector storage of grid
  , voxelGridData :: !(Vector a)
  }


-- | Get size of single dimension of the grid
size :: VoxelGrid a -> Int
size = voxelGridSize
{-# INLINE size #-}

-- | Get amount of voxels inside the grid.
length :: VoxelGrid a -> Int
length g = s * s * s
  where
    s = size g
{-# INLINE length #-}

-- | /O(1)/ indexing
(!) :: Unbox a => VoxelGrid a -> V3 Int -> a
(!) = undefined
{-# INLINE (!) #-}

-- | /O(1)/ safe indexing
(!?) :: Unbox a => VoxelGrid a -> V3 Int -> Maybe a
(!?) = undefined
{-# INLINE (!?) #-}

-- | /O(1)/ indexing without bound checks
unsafeIndex :: Unbox a => VoxelGrid a -> V3 Int -> a
unsafeIndex = undefined
{-# INLINE unsafeIndex #-}

-- | /O(1)/ Create new empty grid with given size
empty :: Unbox a => Int -> VoxelGrid a
empty = undefined
{-# INLINE empty #-}

-- | /O(n)/ Create new grid filled with value
replicate :: Unbox a => Int -> a -> VoxelGrid a
replicate = undefined
{-# INLINE replicate #-}

-- | /O(n)/ Create new grid by applying the function to each position
generate :: Unbox a => Int -> (V3 Int -> a) -> VoxelGrid a
generate = undefined
{-# INLINE generate #-}

-- | /O(n)/ Execute the monadic action the given number of times and store the results in a grid
replicateM :: (Monad m, Unbox a) => Int -> m a -> m (VoxelGrid a)
replicateM = undefined
{-# INLINE replicateM #-}

-- | /O(n)/ Construct grid of given length by applying monadic action to each index
generateM :: (Monad m, Unbox a) => Int -> (V3 Int -> m a) -> m (VoxelGrid a)
generateM = undefined
{-# INLINE generateM #-}

-- | Execute monadic action and freeze resulted grid.
create :: Unbox a => (forall s . ST s (MVoxelGrid s a)) -> m (VoxelGrid a)
create _ = undefined
{-# INLINE create #-}

-- | /O(m+n)/ For each pair (i,a) from the list, replace the grid element at position i by a.
(//) :: Unbox a
  => VoxelGrid a -- ^ Initial grid (of length m)
  -> [(V3 Int, a)] -- ^ list of index/value (of length n)
  -> VoxelGrid a
(//) = undefined
{-# INLINE (//) #-}

-- | Same as (//) but without bounds checking.
unsafeUpd :: Unbox a
  => VoxelGrid a -- ^ Initial grid (of length m)
  -> [(V3 Int, a)] -- ^ list of index/value (of length n)
  -> VoxelGrid a
unsafeUpd = undefined
{-# INLINE unsafeUpd #-}

-- | Apply a destructive operation to a grid. The operation will be performed
-- in place if it is safe to do so and will modify a copy of the vector otherwise.
modify :: Unbox a => (forall s . MVoxelGrid s a -> ST s ()) -> VoxelGrid a -> VoxelGrid a
modify _ = undefined
{-# INLINE modify #-}

-- | /O(n)/ Pair each element in a grid with its index
indexed :: Unbox a => VoxelGrid a -> VoxelGrid (V3 Int, a)
indexed = undefined
{-# INLINE indexed #-}

-- | /O(n)/ Map a function over a grid
map :: (Unbox a, Unbox b) => (a -> b) -> VoxelGrid a -> VoxelGrid b
map = undefined
{-# INLINE map #-}

-- | /O(n)/ Apply a function to every element of a vector and its index
imap :: (Unbox a, Unbox b) => (V3 Int -> a -> b) -> VoxelGrid a -> VoxelGrid b
imap = undefined
{-# INLINE imap #-}

-- | /O(n)/ Apply the monadic action to all elements of the vector, yielding a vector of results
mapM :: (Monad m, Unbox a, Unbox b) => (a -> m b) -> VoxelGrid a -> m (VoxelGrid b)
mapM = undefined
{-# INLINE mapM #-}

-- | /O(n)/ Apply the monadic action to every element of a vector and its index, yielding a vector of results
imapM :: (Monad m, Unbox a, Unbox b) => (V3 Int -> a -> m b) -> VoxelGrid a -> m (VoxelGrid b)
imapM = undefined
{-# INLINE imapM #-}

-- | /O(n)/ Apply the monadic action to all elements of the vector, yielding a vector of results
mapM_ :: (Monad m, Unbox a) => (a -> m b) -> VoxelGrid a -> m ()
mapM_ = undefined
{-# INLINE mapM_ #-}

-- | /O(n)/ Apply the monadic action to every element of a vector and its index, yielding a vector of results
imapM_ :: (Monad m, Unbox a) => (V3 Int -> a -> m b) -> VoxelGrid a -> m ()
imapM_ = undefined
{-# INLINE imapM_ #-}

-- | /O(n)/ Apply the monadic action to all elements of the vector, yielding a vector of results. Equivalent to flip 'mapM'.
forM :: (Monad m, Unbox a, Unbox b) => VoxelGrid a -> (a -> m b) -> m (VoxelGrid b)
forM = undefined
{-# INLINE forM #-}

-- | /O(n)/ Apply the monadic action to all elements of the vector, yielding a vector of results. Equivalent to flip 'mapM_'.
forM_ :: (Monad m, Unbox a) => VoxelGrid a -> (a -> m b) -> m ()
forM_ = undefined
{-# INLINE forM_ #-}

infix 4 `elem`
-- | /O(n)/ Check if the grid contains an element
elem :: (Unbox a, Eq a) => a -> VoxelGrid a -> Bool
elem = undefined
{-# INLINE elem #-}

infix 4 `notElem`
-- | /O(n)/ Check if the grid does not contain an element (inverse of 'elem')
notElem :: (Unbox a, Eq a) => a -> VoxelGrid a -> Bool
notElem = undefined
{-# INLINE notElem #-}

-- | /O(n)/ Yield 'Just' the first element matching the predicate or 'Nothing'
-- if no such element exists.
find :: Unbox a => (a -> Bool) -> VoxelGrid a -> Maybe a
find = undefined
{-# INLINE find #-}

-- | /O(n)/ Yield 'Just' the index of the first element matching the predicate
-- or 'Nothing' if no such element exists.
findIndex :: Unbox a => (a -> Bool) -> VoxelGrid a -> Maybe Int
findIndex = undefined
{-# INLINE findIndex #-}

-- | /O(n)/ Yield the indices of elements satisfying the predicate in ascending
-- order.
findIndecies :: Unbox a => (a -> Bool) -> VoxelGrid a -> Vector Int
findIndecies = undefined
{-# INLINE findIndecies #-}

-- | /O(n)/ Yield 'Just' the index of the first occurence of the given element or
-- 'Nothing' if the grid does not contain the element. This is a specialised
-- version of 'findIndex'.
elemIndex :: (Unbox a, Eq a) => a -> VoxelGrid a -> Maybe Int
elemIndex = undefined
{-# INLINE elemIndex #-}

-- | O(n) Yield the indices of all occurences of the given element in ascending
-- order. This is a specialised version of findIndices.
elemIndecies :: (Unbox a, Eq a) => a -> VoxelGrid a -> VoxelGrid Int
elemIndecies = undefined
{-# INLINE elemIndecies #-}

-- | /O(n)/ Left fold
foldl :: Unbox b => (a -> b -> a) -> a -> VoxelGrid b -> a
foldl = undefined
{-# INLINE foldl #-}

-- | /O(n)/ Left fold on non-empty vectors
foldl1 :: Unbox a => (a -> a -> a) -> VoxelGrid a -> a
foldl1 = undefined
{-# INLINE foldl1 #-}

-- | /O(n)/ Left fold with strict accumulator
foldl' :: Unbox b => (a -> b -> a) -> a -> VoxelGrid b -> a
foldl' = undefined
{-# INLINE foldl' #-}

-- | /O(n)/ Left fold on non-empty vectors with strict accumulator
foldl1' :: Unbox a => (a -> a -> a) -> VoxelGrid a -> a
foldl1' = undefined
{-# INLINE foldl1' #-}

-- | /O(n)/ Right fold
foldr :: Unbox a => (a -> b -> b) -> b -> VoxelGrid a -> b
foldr = undefined
{-# INLINE foldr #-}

-- | /O(n)/ Right fold on non-empty vectors
foldr1 :: Unbox a => (a -> a -> a) -> VoxelGrid a -> a
foldr1 = undefined
{-# INLINE foldr1 #-}

-- | /O(n)/ Right fold with a strict accumulator
foldr' :: Unbox a => (a -> b -> b) -> b -> VoxelGrid a -> b
foldr' = undefined
{-# INLINE foldr' #-}

-- | /O(n)/ Right fold on non-empty vectors with strict accumulator
foldr1' :: Unbox a => (a -> a -> a) -> VoxelGrid a -> a
foldr1' = undefined
{-# INLINE foldr1' #-}

-- | /O(n)/ Left fold (function applied to each element and its index)
ifoldl :: Unbox b => (a -> V3 Int -> b -> a) -> a -> VoxelGrid b -> a
ifoldl = undefined
{-# INLINE ifoldl #-}

-- | /O(n)/ Left fold with strict accumulator (function applied to each element
-- and its index)
ifoldl' :: Unbox b => (a -> V3 Int -> b -> a) -> a -> VoxelGrid b -> a
ifoldl' = undefined
{-# INLINE ifoldl' #-}

-- | /O(n)/ Right fold (function applied to each element and its index)
ifoldr :: Unbox a => (V3 Int -> a -> b -> b) -> b -> VoxelGrid a -> b
ifoldr = undefined
{-# INLINE ifoldr #-}

-- | /O(n)/ Right fold with strict accumulator (function applied to each
-- element and its index)
ifoldr' :: Unbox a => (V3 Int -> a -> b -> b) -> b -> VoxelGrid a -> b
ifoldr' = undefined
{-# INLINE ifoldr' #-}

-- | /O(n)/ Check if all elements satisfy the predicate.
all :: Unbox a => (a -> Bool) -> VoxelGrid a -> Bool
all = undefined
{-# INLINE all #-}

-- | /O(n)/ Check if any element satisfies the predicate.
any :: Unbox a => (a -> Bool) -> VoxelGrid a -> Bool
any = undefined
{-# INLINE any #-}

-- | /O(n)/ Yield the maximum element of the grid.
maximum :: (Unbox a, Ord a) => VoxelGrid a -> a
maximum = undefined
{-# INLINE maximum #-}

-- | /O(n)/ Yield the maximum element of the grid according to the given
-- comparison function.
maximumBy :: Unbox a => (a -> a -> Ordering) -> VoxelGrid a -> a
maximumBy = undefined
{-# INLINE maximumBy #-}

-- | /O(n)/ Yield the minimum element of the grid.
minimum :: (Unbox a, Ord a) => VoxelGrid a -> a
minimum = undefined
{-# INLINE minimum #-}

-- | /O(n)/ Yield the minimum element of the grid according to the given
-- comparison function.
minimumBy :: Unbox a => (a -> a -> Ordering) -> VoxelGrid a -> a
minimumBy = undefined
{-# INLINE minimumBy #-}

-- | /O(n)/ Yield the index of the maximum element of the grid.
maxIndex :: (Unbox a, Ord a) => VoxelGrid a -> Int
maxIndex = undefined
{-# INLINE maxIndex #-}

-- | /O(n)/ Yield the index of the maximum element of the grid according to
-- the given comparison function.
maxIndexBy :: Unbox a => (a -> a -> Ordering) -> VoxelGrid a -> Int
maxIndexBy = undefined
{-# INLINE maxIndexBy #-}

-- | /O(n)/ Yield the index of the minimum element of the grid.
minIndex :: (Unbox a, Ord a) => VoxelGrid a -> Int
minIndex = undefined
{-# INLINE minIndex #-}

-- | /O(n)/ Yield the index of the minimum element of the grid according to
-- the given comparison function.
minIndexBy :: Unbox a => (a -> a -> Ordering) -> VoxelGrid a -> Int
minIndexBy = undefined
{-# INLINE minIndexBy #-}

-- | /O(n)/ Monadic fold
foldM :: (Monad m, Unbox b) => (a -> b -> m a) -> a -> VoxelGrid b -> m a
foldM = undefined
{-# INLINE foldM #-}

-- | /O(n)/ Monadic fold (action applied to each element and its index)
ifoldM :: (Monad m, Unbox b) => (a -> V3 Int -> b -> m a) -> a -> VoxelGrid b -> m a
ifoldM = undefined
{-# INLINE ifoldM #-}

-- | /O(n)/ Monadic fold over non-empty vectors
fold1M :: (Monad m, Unbox a) => (a -> a -> m a) -> VoxelGrid a -> m a
fold1M = undefined
{-# INLINE fold1M #-}

-- | /O(n)/ Monadic fold with strict accumulator
foldM' :: (Monad m, Unbox b) => (a -> b -> m a) -> a -> VoxelGrid b -> m a
foldM' = undefined
{-# INLINE foldM' #-}

-- | /O(n)/ Monadic fold with strict accumulator (action applied to each
-- element and its index)
ifoldM' :: (Monad m, Unbox b) => (a -> V3 Int -> b -> m a) -> a -> VoxelGrid b -> m a
ifoldM' = undefined
{-# INLINE ifoldM' #-}

-- | /O(n)/ Monadic fold over non-empty vectors with strict accumulator
fold1M' :: (Monad m, Unbox a) => (a -> a -> m a) -> VoxelGrid a -> m a
fold1M' = undefined
{-# INLINE fold1M' #-}

-- | /O(n)/ Monadic fold that discards the result
foldM_ :: (Monad m, Unbox b) => (a -> b -> m a) -> a -> VoxelGrid b -> m ()
foldM_ = undefined
{-# INLINE foldM_ #-}

-- | /O(n)/ Monadic fold that discards the result (action applied to each
-- element and its index)
ifoldM_ :: (Monad m, Unbox b) => (a -> V3 Int -> b -> m a) -> a -> VoxelGrid b -> m ()
ifoldM_ = undefined
{-# INLINE ifoldM_ #-}

-- | /O(n)/ Monadic fold over non-empty vectors that discards the result
fold1M_ :: (Monad m, Unbox a) => (a -> a -> m a) -> VoxelGrid a -> m ()
fold1M_ = undefined
{-# INLINE fold1M_ #-}

-- | /O(n)/ Monadic fold with strict accumulator that discards the result
foldM'_ :: (Monad m, Unbox b) => (a -> b -> m a) -> a -> VoxelGrid b -> m ()
foldM'_ = undefined
{-# INLINE foldM'_ #-}

-- | /O(n)/ Monadic fold with strict accumulator that discards the result
-- (action applied to each element and its index)
ifoldM'_ :: (Monad m, Unbox b)
         => (a -> V3 Int -> b -> m a) -> a -> VoxelGrid b -> m ()
ifoldM'_ = undefined
{-# INLINE ifoldM'_ #-}

-- | /O(n)/ Monadic fold over non-empty vectors with strict accumulator
-- that discards the result
fold1M'_ :: (Monad m, Unbox a) => (a -> a -> m a) -> VoxelGrid a -> m ()
fold1M'_ = undefined
{-# INLINE fold1M'_ #-}

-- | /O(n)/ Convert a grid to a list
toList :: Unbox a => VoxelGrid a -> [a]
toList = undefined
{-# INLINE toList #-}

-- | /O(n)/ Convert a list to a grid
fromList :: Unbox a => Int -> [a] -> VoxelGrid a
fromList = undefined
{-# INLINE fromList #-}

-- | /O(1)/ Unsafe convert a mutable grid to an immutable one without
-- copying. The mutable grid may not be used after this operation.
unsafeFreeze :: (Unbox a, PrimMonad m) => MVoxelGrid (PrimState m) a -> m (VoxelGrid a)
unsafeFreeze = undefined
{-# INLINE unsafeFreeze #-}

-- | /O(1)/ Unsafely convert an immutable grid to a mutable one without
-- copying. The immutable grid may not be used after this operation.
unsafeThaw :: (Unbox a, PrimMonad m) => VoxelGrid a -> m (MVoxelGrid (PrimState m) a)
unsafeThaw = undefined
{-# INLINE unsafeThaw #-}

-- | /O(n)/ Yield a mutable copy of the immutable grid.
thaw :: (Unbox a, PrimMonad m) => VoxelGrid a -> m (MVoxelGrid (PrimState m) a)
thaw = undefined
{-# INLINE thaw #-}

-- | /O(n)/ Yield an immutable copy of the mutable grid.
freeze :: (Unbox a, PrimMonad m) => MVoxelGrid (PrimState m) a -> m (VoxelGrid a)
freeze = undefined
{-# INLINE freeze #-}

-- | /O(n)/ Copy an immutable grid into a mutable one. The two grids must
-- have the same length. This is not checked.
unsafeCopy
  :: (Unbox a, PrimMonad m) => MVoxelGrid (PrimState m) a -> VoxelGrid a -> m ()
unsafeCopy = undefined
{-# INLINE unsafeCopy #-}

-- | /O(n)/ Copy an immutable grid into a mutable one. The two grids must
-- have the same length.
copy :: (Unbox a, PrimMonad m) => MVoxelGrid (PrimState m) a -> VoxelGrid a -> m ()
copy = undefined
{-# INLINE copy #-}
