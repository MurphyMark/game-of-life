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
updateCells length width =
    updateCellsBetween ( 0, 0 ) ( length, width )


updateCellsBetween : Cell -> Cell -> Set Cell -> Set Cell
updateCellsBetween c1 c2 cells =
    cellSet c1 c2
        |> Set.foldr updateCell cells


updateCell : Cell -> Set Cell -> Set Cell
updateCell cell cells =
    let
        living =
            alive cell cells

        neighbors =
            countNeighbors cell cells

        willAdd =
            willLive living neighbors
    in
    if willAdd then
        Set.insert cell cells
    else
        Set.remove cell cells


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
    List.member neighbors (List.range 2 4)


willLiveDead : Int -> Bool
willLiveDead neighbors =
    neighbors == 3
