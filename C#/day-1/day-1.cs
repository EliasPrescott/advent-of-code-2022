using System.Linq;

public static class DayOne {
    private static int? ParseIntNullable(string s) {
        if (int.TryParse(s, out int x)) {
            return x;
        }
        return null;
    }

    public static int PartOneSolver(string inputPath) =>
        File.ReadAllLines(inputPath)
            .Select(ParseIntNullable)
            .Aggregate(new List<List<int>>() {new List<int>()}, (state, x) => {
                if (x is null) {
                    return state.Append(new List<int>()).ToList();
                }
                else {
                    state.Last().Add((int)x);
                    return state;
                }
            })
            .Select(x => x.Sum())
            .Max();

    public static int PartTwoSolver(string inputPath) =>
        File.ReadAllLines(inputPath)
            .Select(ParseIntNullable)
            .Aggregate(new List<List<int>>() {new List<int>()}, (state, x) => {
                if (x is null) {
                    return state.Append(new List<int>()).ToList();
                }
                else {
                    state.Last().Add((int)x);
                    return state;
                }
            })
            .Select(x => x.Sum())
            .OrderByDescending(x => x)
            .Take(3)
            .Sum();
}