defmodule Day2 do
  defp get_game_matches() do
    InputReader.get_input_from_day(2)
    |> InputReader.get_lines_from_input()
    |> Enum.map(fn game_turn ->
      game_turn |> String.split(" ")
    end)
  end

  def get_score_from_strategy_guide() do
    get_game_matches()
    |> Enum.map(&get_score_match(&1))
    |> Enum.map(&get_score_shape(&1))
    |> Enum.map(&get_game_score(&1))
    |> Enum.reduce(&(&1 + &2))
  end

  defp get_game_score({_game, match_points, shape_points}) do
    match_points + shape_points
  end

  defp get_score_match([foe, me]) do
    coordinates_system = %{"A" => 0, "B" => 1, "C" => 2, "X" => 0, "Y" => 1, "Z" => 2}
    matrix_desicion = [[0, 1, -1], [-1, 0, 1], [1, -1, 0]]

    desicion =
      matrix_desicion |> Enum.at(coordinates_system[foe]) |> Enum.at(coordinates_system[me])

    case desicion do
      -1 -> {[foe, me], 0}
      0 -> {[foe, me], 3}
      1 -> {[foe, me], 6}
    end
  end

  defp get_score_shape({[foe, me], match_points}) do
    shapes = %{"A" => 1, "B" => 2, "C" => 3, "X" => 1, "Y" => 2, "Z" => 3}
    {[foe, me], match_points, shapes[me]}
  end
end
