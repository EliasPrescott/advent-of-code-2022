module DayTwo

open System.IO

type Choice = 
    | Rock
    | Paper
    | Scissors

module Choice =
    let Value c =
        match c with
        | Rock -> 1
        | Paper -> 2
        | Scissors -> 3

let stringToChoice s =
    match s with
    | "A" | "X" -> Rock
    | "B" | "Y" -> Paper
    | "C" | "Z" -> Scissors

let partOneSolver inputPath =
    File.ReadAllLines inputPath
    |> Array.map (fun x -> x.Split(' ') |> Array.map stringToChoice)
    |> Array.map (fun x ->
        match (x[0], x[1]) with
        | Rock, Paper | Paper, Scissors | Scissors, Rock -> 6
        | Rock, Rock | Paper, Paper | Scissors, Scissors -> 3
        | Rock, Scissors | Paper, Rock | Scissors, Paper -> 0
        |> fun y -> y + Choice.Value x[1])
    |> Array.sum

type Outcome =
    | Win
    | Draw
    | Loss

module Outcome =
    let Parse s =
        match s with
        | "X" -> Loss
        | "Y" -> Draw
        | "Z" -> Win

    let Value o =
        match o with
        | Win -> 6
        | Draw -> 3
        | Loss -> 0

let partTwoSolver inputPath =
    File.ReadAllLines inputPath
    |> Array.map (fun x -> x.Split(' ') |> fun y -> (stringToChoice y[0], Outcome.Parse y[1]))
    |> Array.map (fun (oppChoice, desiredOutcome) ->
        match (oppChoice, desiredOutcome) with
        | Rock, Win | Paper, Draw | Scissors, Loss -> Paper
        | Paper, Win | Scissors, Draw | Rock, Loss -> Scissors
        | Scissors, Win | Rock, Draw | Paper, Loss -> Rock
        |> fun x -> Choice.Value x + Outcome.Value desiredOutcome)
    |> Array.sum