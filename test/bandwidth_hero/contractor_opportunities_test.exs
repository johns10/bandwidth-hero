defmodule BandwidthHero.ContractorOpportunitiesTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.ContractorOpportunities

  describe "contractor_opportunities" do
    alias BandwidthHero.ContractorOpportunities.ContractorOpportunity

    import BandwidthHero.ContractorOpportunitiesFixtures

    @invalid_attrs %{message: nil, subject: nil}

    test "list_contractor_opportunities/0 returns all contractor_opportunities" do
      contractor_opportunity = contractor_opportunity_fixture()
      assert ContractorOpportunities.list_contractor_opportunities() == [contractor_opportunity]
    end

    test "get_contractor_opportunity!/1 returns the contractor_opportunity with given id" do
      contractor_opportunity = contractor_opportunity_fixture()
      assert ContractorOpportunities.get_contractor_opportunity!(contractor_opportunity.id) == contractor_opportunity
    end

    test "create_contractor_opportunity/1 with valid data creates a contractor_opportunity" do
      valid_attrs = %{message: "some message", subject: "some subject"}

      assert {:ok, %ContractorOpportunity{} = contractor_opportunity} = ContractorOpportunities.create_contractor_opportunity(valid_attrs)
      assert contractor_opportunity.message == "some message"
      assert contractor_opportunity.subject == "some subject"
    end

    test "create_contractor_opportunity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ContractorOpportunities.create_contractor_opportunity(@invalid_attrs)
    end

    test "update_contractor_opportunity/2 with valid data updates the contractor_opportunity" do
      contractor_opportunity = contractor_opportunity_fixture()
      update_attrs = %{message: "some updated message", subject: "some updated subject"}

      assert {:ok, %ContractorOpportunity{} = contractor_opportunity} = ContractorOpportunities.update_contractor_opportunity(contractor_opportunity, update_attrs)
      assert contractor_opportunity.message == "some updated message"
      assert contractor_opportunity.subject == "some updated subject"
    end

    test "update_contractor_opportunity/2 with invalid data returns error changeset" do
      contractor_opportunity = contractor_opportunity_fixture()
      assert {:error, %Ecto.Changeset{}} = ContractorOpportunities.update_contractor_opportunity(contractor_opportunity, @invalid_attrs)
      assert contractor_opportunity == ContractorOpportunities.get_contractor_opportunity!(contractor_opportunity.id)
    end

    test "delete_contractor_opportunity/1 deletes the contractor_opportunity" do
      contractor_opportunity = contractor_opportunity_fixture()
      assert {:ok, %ContractorOpportunity{}} = ContractorOpportunities.delete_contractor_opportunity(contractor_opportunity)
      assert_raise Ecto.NoResultsError, fn -> ContractorOpportunities.get_contractor_opportunity!(contractor_opportunity.id) end
    end

    test "change_contractor_opportunity/1 returns a contractor_opportunity changeset" do
      contractor_opportunity = contractor_opportunity_fixture()
      assert %Ecto.Changeset{} = ContractorOpportunities.change_contractor_opportunity(contractor_opportunity)
    end
  end
end
