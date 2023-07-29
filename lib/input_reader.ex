defmodule InputReader do
  @base_dir "inputs"

  defp read_input(path) do
    path
    |> File.stream!()
  end

  def get_input_from_day(day_num, :sample) do
    read_input("#{@base_dir}/day#{day_num}_sample.txt")
  end

  def get_input_from_day(day_num) do
    read_input("#{@base_dir}/day#{day_num}.txt")
  end

  def get_lines_from_input(input) when is_map(input) do
    input |> Stream.map(&String.trim_trailing(&1, "\n")) |> Enum.to_list()
  end

  def get_lines_from_input(_input) do
    {:error, "You can get lines just from input as stream, first use get_input_from_day function"}
  end

  def split_list_on_empty(list) do
    split_list_on_empty(list, [[]])
  end

  defp split_list_on_empty([], result) do
    Enum.reverse(result)
  end

  defp split_list_on_empty(["" | tail], [current | result]) do
    split_list_on_empty(tail, [[] | [current | result]])
  end

  defp split_list_on_empty([head | tail], [current | result]) do
    split_list_on_empty(tail, [[head | current] | result])
  end

  def get_chunk_lines_from_input(input) when is_map(input) do
    input |> get_lines_from_input() |> split_list_on_empty()
  end

  def get_chunk_lines_from_input(_input) do
    {:error, "You can get lines just from input as stream, first use get_input_from_day function"}
  end
end
