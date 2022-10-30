defmodule BandwidthHeroWeb.ExperienceLive.FormHandlers do
  use BandwidthHeroWeb, :live_component

  alias BandwidthHero.Experiences
  alias BandwidthHero.Experiences.Experience

  @impl true
  def update_socket(%{experience: experience} = assigns, socket) do
    changeset = Experiences.change_experience(experience)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def validate(params, socket) do
    changeset =
      socket.assigns.experience
      |> Experiences.change_experience(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def save_redirect(socket, :edit, experience_params) do
    case Experiences.update_experience(socket.assigns.experience, experience_params) do
      {:ok, _experience} ->
        {:noreply,
         socket
         |> put_flash(:info, "Experience updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_redirect(socket, :new, experience_params) do
    case Experiences.create_experience(experience_params) do
      {:ok, _experience} ->
        {:noreply,
         socket
         |> put_flash(:info, "Experience created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save_no_redirect(socket, :edit, experience_params) do
    case Experiences.update_experience(socket.assigns.experience, experience_params) do
      {:ok, _experience} ->
        {:noreply,
         socket
         |> put_flash(:info, "Experience updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def save_no_redirect(socket, :new, experience_params) do
    case Experiences.create_experience(experience_params) do
      {:ok, _experience} ->
        changeset = Experiences.change_experience(%BandwidthHero.Experiences.Experience{})
        {:noreply,
         socket
         |> put_flash(:info, "Experience created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
