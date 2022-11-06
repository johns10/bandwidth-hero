defmodule BandwidthHero.Availabilities.Availability do
  use Ecto.Schema
  import Ecto.Changeset
  alias BandwidthHero.Contractors.Contractor

  schema "availabilities" do
    field :now, :boolean, virtual: true
    field :available_from, :date

    field :indefinite, :boolean, virtual: true
    field :available_to, :date
    field :hours, :integer
    belongs_to :contractor, Contractor

    timestamps()
  end

  @doc false
  def changeset(availability, attrs) do
    availability
    |> cast(attrs, [:contractor_id, :available_from, :available_to, :now, :indefinite, :hours])
    |> validate_required([:available_from, :available_to, :hours])
    |> case do
      %{changes: %{now: true}} = changeset ->
        put_change(changeset, :available_from, Date.utc_today())

      changeset ->
        changeset
    end
    |> case do
      %{changes: %{indefinite: true}} = changeset ->
        put_change(changeset, :available_to, Date.utc_today() |> Date.add(2 * 365))

      changeset ->
        changeset
    end
    |> check_dates_stack()
    |> exclusion_constraint(:available_from,
      message: "Cannot overlap other availabilities",
      name: :no_overlaps
    )
  end

  defp check_dates_stack(changeset) do
    from = get_field(changeset, :available_from, nil)
    to = get_field(changeset, :available_to, nil)

    case {from, to} do
      {nil, _} ->
        changeset

      {_, nil} ->
        changeset

      {%Date{} = from, %Date{} = to} ->
        case Date.compare(from, to) do
          :gt -> add_error(changeset, :available_to, "To date must be later than from date.")
          :eq -> add_error(changeset, :available_to, "To date must be later than from date.")
          :lt -> changeset
        end
    end
  end
end
