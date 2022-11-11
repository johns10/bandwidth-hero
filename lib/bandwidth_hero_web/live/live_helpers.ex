defmodule BandwidthHeroWeb.LiveHelpers do
  def enum_to_select_list(module, field) do
    Ecto.Enum.values(module, field)
    |> Enum.map(&{&1 |> to_string() |> Recase.to_sentence(), &1})
  end

  def show_list(values) do
    values
    |> Enum.map(&Atom.to_string/1)
    |> Enum.map(&Recase.to_sentence/1)
    |> commafy()
  end

  def commafy(list_of_values, acc \\ "")
  def commafy([item], acc), do: acc <> item
  def commafy([item | tail], acc), do: acc <> item <> ", " <> commafy(tail, acc)
end
