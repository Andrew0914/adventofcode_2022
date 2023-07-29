defmodule Day1 do
  defp get_list_of_total_calores_by_elf(elves_calories) do
    elves_calories
    |> Enum.map(&Enum.map(&1, fn calory_item -> String.to_integer(calory_item) end))
    |> Enum.map(&Enum.reduce(&1, fn calories, acc_calories -> calories + acc_calories end))
  end

  def get_most_calories(elves_calories) when is_list(elves_calories) do
    elves_calories
    |> get_list_of_total_calores_by_elf()
    |> Enum.max()
  end

  def get_most_calories(_lists_calories) do
    {:error, "You must provide a list of calorries [[\"1000\"], [\"2000\", \"3000\"]]"}
  end

  def get_total_calories_from_top3_elves(elves_calories) when is_list(elves_calories) do
    elves_calories
    |> get_list_of_total_calores_by_elf()
    |> Enum.sort(&(&1 >= &2))
    |> Enum.take(3)
    |> Enum.reduce(&(&1 + &2))
  end

  def get_total_calories_from_top3_elves(_lists_calories) do
    {:error, "You must provide a list of calorries [[\"1000\"], [\"2000\", \"3000\"]]"}
  end
end
