defmodule BandwidthHero.TagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.Tags` context.
  """

  @doc """
  Generate a erp_tag.
  """
  def erp_tag_fixture(attrs \\ %{}) do
    {:ok, erp_tag} =
      attrs
      |> Enum.into(%{
        label: "some label",
        parent_id: :hcm
      })
      |> BandwidthHero.Tags.create_erp_tag()

    erp_tag
  end

  def all_valid_erp_tags_fixture() do
    [
      "Learning",
      "Career Development",
      "Goal Management",
      "Performance Management",
      "Talent Review and Succession Planning",
      "Dynamic Skills",
      "Profile Management",
      "Core Human Resources",
      "Benefits",
      "Digital Assistant",
      "HR Help Desk",
      "Journeys",
      "Workforce Compensation",
      "Time and Labor",
      "Health and Safety",
      "Absence Management",
      "Payroll",
      "Recruiting"
    ]
    |> Enum.map(fn name ->
      BandwidthHero.Tags.create_erp_tag(%{
        label: name,
        parent_id: :hcm
      })
    end)
  end
end
