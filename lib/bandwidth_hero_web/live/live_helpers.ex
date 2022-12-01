defmodule BandwidthHeroWeb.LiveHelpers do
  use Phoenix.Component
  use PetalComponents

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

  def bh_form_field_error(assigns) do
    ~H"""
    <%= if has_error?(@form, @field) do %>
      <.form_field_error form={@form} field={@field} class="mt-1" />
    <% else %>
      <div class="text-xs italic text-red-500 invalid-feedback mt-1"><br /></div>
    <% end %>
    """
  end

  defp has_error?(form, field) do
    form
    |> Map.get(:errors, [])
    |> Keyword.get(field, nil)
    |> case do
      nil -> false
      _ -> true
    end
  end
end
