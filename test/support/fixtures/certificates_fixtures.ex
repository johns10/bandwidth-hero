defmodule BandwidthHero.CertificatesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandwidthHero.Certificates` context.
  """

  @doc """
  Generate a certificate.
  """
  def certificate_fixture(attrs \\ %{}) do
    {:ok, certificate} =
      attrs
      |> Enum.into(%{
        description: "some description",
        label: "some label"
      })
      |> BandwidthHero.Certificates.create_certificate()

    certificate
  end
end
