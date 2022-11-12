defmodule BandwidthHero.Fields do
  def none(), do: %{id: nil, label: "None", parent_id: nil}
  def vendor(), do: [none(), %{id: :oracle, label: "Oracle"}]

  def platform(),
    do: [
      none(),
      %{id: :cloud_applications, parent_id: :oracle, label: "Cloud Applications"}
    ]

  def pillar(),
    do: [none(), %{id: :hcm, label: "HCM", parent_id: :cloud_applications}]

  def vendor_select_options(), do: vendor() |> select_options()
  def platform_select_options(), do: platform() |> select_options()
  def pillar_select_options(), do: pillar() |> select_options()

  def platform_select_options(parent_id),
    do: platform() |> filter_parent(parent_id) |> select_options()

  def pillar_select_options(parent_id),
    do: pillar() |> filter_parent(parent_id) |> select_options()

  def vendor_enum(), do: vendor() |> Enum.map(& &1.id)
  def platform_enum(), do: platform() |> Enum.map(& &1.id)
  def pillar_enum(), do: pillar() |> Enum.map(& &1.id)

  def select_options(values), do: Enum.map(values, &{&1.label, &1.id})

  def filter_parent(values, parent_id),
    do: Enum.filter(values, &(&1.parent_id == parent_id || &1.id == nil))
end
