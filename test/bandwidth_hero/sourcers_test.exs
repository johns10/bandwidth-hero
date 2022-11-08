defmodule BandwidthHero.SourcersTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.Sourcers

  describe "sourcers" do
    alias BandwidthHero.Sourcers.Sourcer

    import BandwidthHero.SourcersFixtures

    @invalid_attrs %{description: nil, name: nil, type: nil, website: nil}

    test "list_sourcers/0 returns all sourcers" do
      sourcer = sourcer_fixture()
      assert Sourcers.list_sourcers() == [sourcer]
    end

    test "get_sourcer!/1 returns the sourcer with given id" do
      sourcer = sourcer_fixture()
      assert Sourcers.get_sourcer!(sourcer.id) == sourcer
    end

    test "create_sourcer/1 with valid data creates a sourcer" do
      valid_attrs = %{
        description: "some description",
        name: "some name",
        type: :end_customer,
        website: "some website"
      }

      assert {:ok, %Sourcer{} = sourcer} = Sourcers.create_sourcer(valid_attrs)
      assert sourcer.description == "some description"
      assert sourcer.name == "some name"
      assert sourcer.type == :end_customer
      assert sourcer.website == "some website"
    end

    test "create_sourcer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sourcers.create_sourcer(@invalid_attrs)
    end

    test "update_sourcer/2 with valid data updates the sourcer" do
      sourcer = sourcer_fixture()

      update_attrs = %{
        description: "some updated description",
        name: "some updated name",
        type: :recruiter,
        website: "some updated website"
      }

      assert {:ok, %Sourcer{} = sourcer} = Sourcers.update_sourcer(sourcer, update_attrs)
      assert sourcer.description == "some updated description"
      assert sourcer.name == "some updated name"
      assert sourcer.type == :recruiter
      assert sourcer.website == "some updated website"
    end

    test "update_sourcer/2 with invalid data returns error changeset" do
      sourcer = sourcer_fixture()
      assert {:error, %Ecto.Changeset{}} = Sourcers.update_sourcer(sourcer, @invalid_attrs)
      assert sourcer == Sourcers.get_sourcer!(sourcer.id)
    end

    test "delete_sourcer/1 deletes the sourcer" do
      sourcer = sourcer_fixture()
      assert {:ok, %Sourcer{}} = Sourcers.delete_sourcer(sourcer)
      assert_raise Ecto.NoResultsError, fn -> Sourcers.get_sourcer!(sourcer.id) end
    end

    test "change_sourcer/1 returns a sourcer changeset" do
      sourcer = sourcer_fixture()
      assert %Ecto.Changeset{} = Sourcers.change_sourcer(sourcer)
    end
  end
end
