defmodule BandwidthHeroWeb.OpportunityLive.RequiredSkillsComponent do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Tags
  alias BandwidthHero.Opportunities.RequiredSkills

  @impl true
  def update(assigns, socket) do
    required_skills = %RequiredSkills{vendor_id: nil}

    changeset =
      required_skills
      |> RequiredSkills.changeset()

    {:ok,
     socket
     |> assign(:erp_tags, Tags.list_erp_tags())
     |> assign(:changeset, changeset)
     |> assign(:required_skills, required_skills)
     |> assign(assigns)}
  end

  @impl true
  def handle_event("validate", %{"required_skills" => params}, socket) do
    changeset = socket.assigns.required_skills |> RequiredSkills.changeset(params)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def select_options(tags, type) do
    [
      {"None", nil}
      | tags
        |> Enum.filter(&(&1.type == type))
        |> Enum.map(&{&1.label, &1.id})
    ]
  end
end
