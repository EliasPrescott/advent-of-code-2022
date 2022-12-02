module DayOne

open System.IO

let tryParseInt s =
    try
        s |> int |> Some
    with _ ->
        None

let partOneSolver inputPath =
    File.ReadAllLines inputPath
    |> Array.fold (fun stateList nextLine ->
        match tryParseInt nextLine with
        | Some x ->
            (x :: (stateList |> List.item 0)) :: (stateList |> List.removeAt 0)
        | None -> [] :: stateList) [[]]
    |> List.map List.sum
    |> List.max

let partTwoSolver inputPath =
    File.ReadAllLines inputPath
    |> Array.fold (fun stateList nextLine ->
        match tryParseInt nextLine with
        | Some x ->
            (x :: (stateList |> List.item 0)) :: (stateList |> List.removeAt 0)
        | None -> [] :: stateList) [[]]
    |> List.map List.sum
    |> List.sortDescending
    |> List.take 3
    |> List.sum