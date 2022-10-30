defmodule BandwidthHero.CertificatesTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.Certificates

  describe "certificate" do
    alias BandwidthHero.Certificates.Certificate

    import BandwidthHero.CertificatesFixtures

    @invalid_attrs %{description: nil, label: nil}

    test "list_certificate/0 returns all certificate" do
      certificate = certificate_fixture()
      assert Certificates.list_certificate() == [certificate]
    end

    test "get_certificate!/1 returns the certificate with given id" do
      certificate = certificate_fixture()
      assert Certificates.get_certificate!(certificate.id) == certificate
    end

    test "create_certificate/1 with valid data creates a certificate" do
      valid_attrs = %{description: "some description", label: "some label"}

      assert {:ok, %Certificate{} = certificate} = Certificates.create_certificate(valid_attrs)
      assert certificate.description == "some description"
      assert certificate.label == "some label"
    end

    test "create_certificate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Certificates.create_certificate(@invalid_attrs)
    end

    test "update_certificate/2 with valid data updates the certificate" do
      certificate = certificate_fixture()
      update_attrs = %{description: "some updated description", label: "some updated label"}

      assert {:ok, %Certificate{} = certificate} = Certificates.update_certificate(certificate, update_attrs)
      assert certificate.description == "some updated description"
      assert certificate.label == "some updated label"
    end

    test "update_certificate/2 with invalid data returns error changeset" do
      certificate = certificate_fixture()
      assert {:error, %Ecto.Changeset{}} = Certificates.update_certificate(certificate, @invalid_attrs)
      assert certificate == Certificates.get_certificate!(certificate.id)
    end

    test "delete_certificate/1 deletes the certificate" do
      certificate = certificate_fixture()
      assert {:ok, %Certificate{}} = Certificates.delete_certificate(certificate)
      assert_raise Ecto.NoResultsError, fn -> Certificates.get_certificate!(certificate.id) end
    end

    test "change_certificate/1 returns a certificate changeset" do
      certificate = certificate_fixture()
      assert %Ecto.Changeset{} = Certificates.change_certificate(certificate)
    end
  end
end
