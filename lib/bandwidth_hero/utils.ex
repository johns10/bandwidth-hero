defmodule BandwidthHero.Utils do
  alias BandwidthHero.Tags.ErpTag
  def to_select_options([%ErpTag{} | _] = values), do: Enum.map(values, & {to_string(&1.label), to_string(&1.id)})
end
