defmodule BandwidthHero.OpportunitiesTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.Opportunities

  describe "opportunities" do
    alias BandwidthHero.Opportunities.Opportunity

    import BandwidthHero.OpportunitiesFixtures

    @invalid_attrs %{contract_type: nil, description: nil, from_date: nil, hours: nil, laptop: nil, name: nil, rate: nil, to_date: nil, travel: nil}

    test "list_opportunities/0 returns all opportunities" do
      opportunity = opportunity_fixture()
      assert Opportunities.list_opportunities() == [opportunity]
    end

    test "get_opportunity!/1 returns the opportunity with given id" do
      opportunity = opportunity_fixture()
      assert Opportunities.get_opportunity!(opportunity.id) == opportunity
    end

    test "create_opportunity/1 with valid data creates a opportunity" do
      valid_attrs = %{contract_type: :corp_to_corp, description: "some description", from_date: ~D[2022-11-10], hours: 42, laptop: :use_my_own, name: "some name", rate: "120.5", to_date: ~D[2022-11-10], travel: :"100%"}

      assert {:ok, %Opportunity{} = opportunity} = Opportunities.create_opportunity(valid_attrs)
      assert opportunity.contract_type == :corp_to_corp
      assert opportunity.description == "some description"
      assert opportunity.from_date == ~D[2022-11-10]
      assert opportunity.hours == 42
      assert opportunity.laptop == :use_my_own
      assert opportunity.name == "some name"
      assert opportunity.rate == Decimal.new("120.5")
      assert opportunity.to_date == ~D[2022-11-10]
      assert opportunity.travel == :"100%"
    end

    test "create_opportunity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Opportunities.create_opportunity(@invalid_attrs)
    end

    test "update_opportunity/2 with valid data updates the opportunity" do
      opportunity = opportunity_fixture()
      update_attrs = %{contract_type: :contract_w2, description: "some updated description", from_date: ~D[2022-11-11], hours: 43, laptop: :use_provided_laptop, name: "some updated name", rate: "456.7", to_date: ~D[2022-11-11], travel: :"75%"}

      assert {:ok, %Opportunity{} = opportunity} = Opportunities.update_opportunity(opportunity, update_attrs)
      assert opportunity.contract_type == :contract_w2
      assert opportunity.description == "some updated description"
      assert opportunity.from_date == ~D[2022-11-11]
      assert opportunity.hours == 43
      assert opportunity.laptop == :use_provided_laptop
      assert opportunity.name == "some updated name"
      assert opportunity.rate == Decimal.new("456.7")
      assert opportunity.to_date == ~D[2022-11-11]
      assert opportunity.travel == :"75%"
    end

    test "update_opportunity/2 with invalid data returns error changeset" do
      opportunity = opportunity_fixture()
      assert {:error, %Ecto.Changeset{}} = Opportunities.update_opportunity(opportunity, @invalid_attrs)
      assert opportunity == Opportunities.get_opportunity!(opportunity.id)
    end

    test "delete_opportunity/1 deletes the opportunity" do
      opportunity = opportunity_fixture()
      assert {:ok, %Opportunity{}} = Opportunities.delete_opportunity(opportunity)
      assert_raise Ecto.NoResultsError, fn -> Opportunities.get_opportunity!(opportunity.id) end
    end

    test "change_opportunity/1 returns a opportunity changeset" do
      opportunity = opportunity_fixture()
      assert %Ecto.Changeset{} = Opportunities.change_opportunity(opportunity)
    end
  end
end
