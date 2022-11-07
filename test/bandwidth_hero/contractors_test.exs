defmodule BandwidthHero.ContractorsTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.Contractors

  describe "contractors" do
    alias BandwidthHero.Contractors.Contractor

    import BandwidthHero.ContractorFixtures

    @invalid_attrs %{
      availability: nil,
      bandwidth: nil,
      contract_type: nil,
      international_travel: nil,
      laptop: nil,
      name: nil,
      title: nil,
      travel: nil
    }

    test "list_contractors/0 returns all contractors" do
      contractor = contractor_fixture()
      assert Contractors.list_contractors() == [contractor]
    end

    test "get_contractor!/1 returns the contractor with given id" do
      contractor = contractor_fixture()
      assert Contractors.get_contractor!(contractor.id) == contractor
    end

    test "create_contractor/1 with valid data creates a contractor" do
      valid_attrs = %{
        contract_type: [:corp_to_corp],
        international_travel: :yes,
        laptop: [:use_my_own],
        name: "some name",
        title: "some title",
        travel: [:"100%"]
      }

      assert {:ok, %Contractor{} = contractor} = Contractors.create_contractor(valid_attrs)
      assert contractor.contract_type == [:corp_to_corp]
      assert contractor.international_travel == :yes
      assert contractor.laptop == [:use_my_own]
      assert contractor.name == "some name"
      assert contractor.title == "some title"
      assert contractor.travel == [:"100%"]
    end

    test "create_contractor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contractors.create_contractor(@invalid_attrs)
    end

    test "update_contractor/2 with valid data updates the contractor" do
      contractor = contractor_fixture()

      update_attrs = %{
        contract_type: [:contract_w2],
        international_travel: :no,
        laptop: [:use_provided_laptop],
        name: "some updated name",
        title: "some updated title",
        travel: [:"75%"]
      }

      assert {:ok, %Contractor{} = contractor} =
               Contractors.update_contractor(contractor, update_attrs)

      assert contractor.contract_type == [:contract_w2]
      assert contractor.international_travel == :no
      assert contractor.laptop == [:use_provided_laptop]
      assert contractor.name == "some updated name"
      assert contractor.title == "some updated title"
      assert contractor.travel == [:"75%"]
    end

    test "update_contractor/2 with invalid data returns error changeset" do
      contractor = contractor_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Contractors.update_contractor(contractor, @invalid_attrs)

      assert contractor == Contractors.get_contractor!(contractor.id)
    end

    test "delete_contractor/1 deletes the contractor" do
      contractor = contractor_fixture()
      assert {:ok, %Contractor{}} = Contractors.delete_contractor(contractor)
      assert_raise Ecto.NoResultsError, fn -> Contractors.get_contractor!(contractor.id) end
    end

    test "change_contractor/1 returns a contractor changeset" do
      contractor = contractor_fixture()
      assert %Ecto.Changeset{} = Contractors.change_contractor(contractor)
    end
  end
end
