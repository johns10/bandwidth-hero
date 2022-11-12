defmodule BandwidthHero.OpportunityErpTagsTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.OpportunityErpTags

  describe "opportunity_erp_tags" do
    alias BandwidthHero.OpportunityErpTags.OpportunityErpTag

    import BandwidthHero.OpportunityErpTagsFixtures
    alias BandwidthHero.OpportunitiesFixtures
    alias BandwidthHero.TagsFixtures

    @invalid_attrs %{projects: nil, years: nil, opportunity_id: nil, erp_tag_id: nil}

    setup do
      opportunity = OpportunitiesFixtures.opportunity_fixture()
      erp_tag = TagsFixtures.erp_tag_fixture()
      %{opportunity_id: opportunity.id, erp_tag_id: erp_tag.id}
    end

    test "list_opportunity_erp_tags/0 returns all opportunity_erp_tags", context do
      opportunity_erp_tag = opportunity_erp_tag_fixture(context)
      assert OpportunityErpTags.list_opportunity_erp_tags() == [opportunity_erp_tag]
    end

    test "get_opportunity_erp_tag!/1 returns the opportunity_erp_tag", context do
      opportunity_erp_tag = opportunity_erp_tag_fixture(context)

      assert OpportunityErpTags.get_opportunity_erp_tag!(opportunity_erp_tag.id) ==
               opportunity_erp_tag
    end

    test "create_opportunity_erp_tag/1 with valid data creates", context do
      valid_attrs = %{projects: 42, years: 42} |> Map.merge(context)

      assert {:ok, %OpportunityErpTag{} = opportunity_erp_tag} =
               OpportunityErpTags.create_opportunity_erp_tag(valid_attrs)

      assert opportunity_erp_tag.projects == 42
      assert opportunity_erp_tag.years == 42
    end

    test "create_opportunity_erp_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               OpportunityErpTags.create_opportunity_erp_tag(@invalid_attrs)
    end

    test "update_opportunity_erp_tag/2 with valid data updates", context do
      opportunity_erp_tag = opportunity_erp_tag_fixture(context)
      update_attrs = %{projects: 43, years: 43}

      assert {:ok, %OpportunityErpTag{} = opportunity_erp_tag} =
               OpportunityErpTags.update_opportunity_erp_tag(opportunity_erp_tag, update_attrs)

      assert opportunity_erp_tag.projects == 43
      assert opportunity_erp_tag.years == 43
    end

    test "update_opportunity_erp_tag/2 with invalid data returns error changeset", context do
      opportunity_erp_tag = opportunity_erp_tag_fixture(context)

      assert {:error, %Ecto.Changeset{}} =
               OpportunityErpTags.update_opportunity_erp_tag(opportunity_erp_tag, @invalid_attrs)

      assert opportunity_erp_tag ==
               OpportunityErpTags.get_opportunity_erp_tag!(opportunity_erp_tag.id)
    end

    test "delete_opportunity_erp_tag/1 deletes the opportunity_erp_tag", context do
      opportunity_erp_tag = opportunity_erp_tag_fixture(context)

      assert {:ok, %OpportunityErpTag{}} =
               OpportunityErpTags.delete_opportunity_erp_tag(opportunity_erp_tag)

      assert_raise Ecto.NoResultsError, fn ->
        OpportunityErpTags.get_opportunity_erp_tag!(opportunity_erp_tag.id)
      end
    end

    test "change_opportunity_erp_tag/1 returns a opportunity_erp_tag changeset", context do
      opportunity_erp_tag = opportunity_erp_tag_fixture(context)

      assert %Ecto.Changeset{} =
               OpportunityErpTags.change_opportunity_erp_tag(opportunity_erp_tag)
    end
  end
end
