defmodule BandwidthHero.Initialize do
  def init() do
  end

  def create_all_erp_tags() do
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
