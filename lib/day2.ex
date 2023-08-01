defmodule Day2 do
  defp get_game_matches() do
    InputReader.get_input_from_day(2)
    |> InputReader.get_lines_from_input()
    |> Enum.map(fn game_turn ->
      game_turn |> String.split(" ")
    end)
  end

  defp get_game_score(matches) do
    matches
    |> Enum.map(&get_score_match(&1))
    |> Enum.map(&get_score_shape(&1))
    |> Enum.map(&get_compund_score(&1))
    |> Enum.reduce(&(&1 + &2))
  end

  def get_score_from_strategy_guide() do
    get_game_matches() |> get_game_score()
  end

  def get_score_from_strategy_guide_with_forecast() do
    get_game_matches()
    |> Enum.map(fn [foe, me] ->
      [foe, get_spin_based_on_forecast([foe, me])]
    end)
    |> get_game_score()
  end

  defp get_compund_score({_game, match_points, shape_points}) do
    match_points + shape_points
  end

  defp get_score_match([foe, me]) do
    coordinates = %{"A" => 0, "B" => 1, "C" => 2, "X" => 0, "Y" => 1, "Z" => 2}
    matrix_desicion = [[0, 1, -1], [-1, 0, 1], [1, -1, 0]]

    desicion = matrix_desicion |> Enum.at(coordinates[foe]) |> Enum.at(coordinates[me])

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

  defp get_spin_based_on_forecast([foe, forecast]) do
    foe_coordinate = %{"A" => 0, "B" => 1, "C" => 2}
    forecasst_coordinates = %{"X" => 0, "Y" => 1, "Z" => 2}
    forecast_result = %{"X" => -1, "Y" => 0, "Z" => 1}
    matrix_desicion = [[0, 1, -1], [-1, 0, 1], [1, -1, 0]]

    {_value, spin_index} =
      matrix_desicion
      |> Enum.at(foe_coordinate[foe])
      |> Enum.with_index()
      |> Enum.find(fn {result, _index} -> result == forecast_result[forecast] end)

    forecasst_coordinates
    |> Enum.find(fn {_key, coordinate} -> coordinate == spin_index end)
    |> elem(0)
  end
end
