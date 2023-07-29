defmodule Day1 do
  def get_most_calories(elves_calories) when is_list(elves_calories) do
    elves_calories
    |> Enum.map(&Enum.map(&1, fn calory_item -> String.to_integer(calory_item) end))
    |> Enum.map(&Enum.reduce(&1, fn calories, acc_calories -> calories + acc_calories end))
    |> Enum.max()
  end

  def get_most_calories(_lists_calories) do
    {:error, "You must provide a list of calorries [[\"1000\"], [\"2000\", \"3000\"]]"}
  end
end
