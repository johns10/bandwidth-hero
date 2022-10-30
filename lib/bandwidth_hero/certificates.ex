defmodule BandwidthHero.Certificates do
  @moduledoc """
  The Certificates context.
  """

  import Ecto.Query, warn: false
  alias BandwidthHero.Repo

  alias BandwidthHero.Certificates.Certificate

  def list_certificate do
    Certificate
    |> Repo.all()
  end

  def get_certificate!(id), do: Repo.get!(Certificate, id)

  def create_certificate(attrs \\ %{}) do
    %Certificate{}
    |> Certificate.changeset(attrs)
    |> Repo.insert()
  end

  def update_certificate(%Certificate{} = certificate, attrs) do
    certificate
    |> Certificate.changeset(attrs)
    |> Repo.update()
  end

  def delete_certificate(%Certificate{} = certificate) do
    Repo.delete(certificate)
  end

  def change_certificate(%Certificate{} = certificate, attrs \\ %{}) do
    Certificate.changeset(certificate, attrs)
  end
end
