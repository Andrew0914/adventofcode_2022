defmodule Day3 do
  defp split_rucksack_compartments(rucksak) when is_binary(rucksak) do
    half = Integer.floor_div(String.length(rucksak), 2)
    {items_a, items_b} = rucksak |> String.split_at(half)
    [items_a, items_b]
  end

  defp split_items(rucksack_compartmens)
       when is_list(rucksack_compartmens) and length(rucksack_compartmens) <= 3 do
    rucksack_compartmens |> Enum.map(&String.graphemes/1)
  end

  defp calculate_duplicated_items([[head | tail], items_b], repeated_items) do
    if Enum.find(items_b, &(&1 == head)) != nil,
      do: calculate_duplicated_items([tail, items_b], repeated_items ++ [head]),
      else: calculate_duplicated_items([tail, items_b], repeated_items)
  end

  defp calculate_duplicated_items([[head | tail], items_b, items_c], repeated_items) do
    if Enum.find(items_b, &(&1 == head)) != nil and Enum.find(items_c, &(&1 == head)) != nil,
      do: calculate_duplicated_items([tail, items_b, items_c], repeated_items ++ [head]),
      else: calculate_duplicated_items([tail, items_b, items_c], repeated_items)
  end

  defp calculate_duplicated_items([[] | _tail], repeated_items) do
    repeated_items |> Enum.uniq()
  end

  defp items_to_priority(items) do
    items
    |> Enum.map(fn item ->
      <<item_ascii::utf8>> = item

      cond do
        String.match?("#{item}", ~r/[A-Z]+/) -> item_ascii - 38
        String.match?("#{item}", ~r/[a-z]+/) -> item_ascii - 96
        true -> 0
      end
    end)
  end

  defp get_rucksack_reapeated_items_priorities(rucksack) when is_binary(rucksack) do
    rucksack
    |> split_rucksack_compartments()
    |> split_items()
    |> calculate_duplicated_items([])
    |> items_to_priority()
    |> Enum.reduce(&(&1 + &2))
  end

  def get_total_rucksacks_priorities() do
    InputReader.get_input_from_day(3)
    |> InputReader.get_lines_from_input()
    |> Enum.map(&get_rucksack_reapeated_items_priorities(&1))
    |> Enum.reduce(&(&1 + &2))
  end

  defp group_three_rucksacks(rucksacks) do
    rucksacks |> Enum.chunk_every(3)
  end

  defp get_rucksacks_group_priorities(rucksack_group) do
    rucksack_group
    |> split_items()
    |> calculate_duplicated_items([])
    |> items_to_priority()
    |> Enum.reduce(&(&1 + &2))
  end

  def get_total_rucksacks_groups_priorities() do
    InputReader.get_input_from_day(3)
    |> InputReader.get_lines_from_input()
    |> group_three_rucksacks()
    |> Enum.map(&get_rucksacks_group_priorities(&1))
    |> Enum.reduce(&(&1 + &2))
  end
end
