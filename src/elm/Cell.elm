module Cell exposing (..)

import Set exposing (Set)


type alias Cell =
    ( Int, Int )


cellSet : Cell -> Cell -> Set Cell
cellSet ( x1, y1 ) ( x2, y2 ) =
    let
        xRange =
            List.range x1 x2

        yRange =
            List.range y1 y2
    in
    Set.fromList <| combinations xRange yRange


alive : Cell -> Set Cell -> Bool
alive =
    Set.member


flipCell : Cell -> Set Cell -> Set Cell
flipCell cell cells =
    if alive cell cells then
        Set.remove cell cells
    else
        Set.insert cell cells


updateCells : Int -> Int -> Set Cell -> Set Cell
updateCells width height =
    updateCellsBetween ( 0, 0 ) ( width, height )



-- PROBLEM: Each cell update passes the updated cell-set to the next update,
-- when they all need to use the old one :/


updateCellsBetween : Cell -> Cell -> Set Cell -> Set Cell
updateCellsBetween c1 c2 cells =
    cellSet c1 c2
        |> Set.foldr (updateCell cells) cells


{-| Given the cell-set from last tick, and the cell-set being built,
Updates the new cell-set with this cell's living status.
-}
updateCell : Set Cell -> Cell -> Set Cell -> Set Cell
updateCell oldCells cell newCells =
    let
        living =
            alive cell oldCells

        neighbors =
            countNeighbors cell oldCells

        willAdd =
            willLive living neighbors
    in
    if willAdd then
        Set.insert cell newCells
    else
        Set.remove cell newCells


countNeighbors : Cell -> Set Cell -> Int
countNeighbors ( x, y ) cells =
    let
        xRange =
            List.range (x - 1) (x + 1)

        yRange =
            List.range (y - 1) (y + 1)

        check cell cells =
            if alive cell cells then
                1
            else
                0
    in
    combinations xRange yRange
        |> Set.fromList
        |> Set.remove ( x, y )
        |> Set.toList
        |> List.map (\x -> check x cells)
        |> List.foldr (+) 0


combinations : List a -> List b -> List ( a, b )
combinations xs ys =
    let
        oneCombination : a -> List b -> List ( a, b )
        oneCombination x xs =
            List.map ((,) x) xs
    in
    xs
        |> List.map (\x -> oneCombination x ys)
        |> List.concat


willLive : Bool -> Int -> Bool
willLive living =
    if living then
        willLiveLiving
    else
        willLiveDead


willLiveLiving : Int -> Bool
willLiveLiving neighbors =
    List.member neighbors (List.range 2 3)


willLiveDead : Int -> Bool
willLiveDead neighbors =
    neighbors == 3
