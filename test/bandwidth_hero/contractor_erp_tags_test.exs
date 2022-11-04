defmodule BandwidthHero.ContractorErpTagsTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.ContractorErpTags

  describe "contractor_erp_tag" do
    alias BandwidthHero.ContractorErpTags.ContractorErpTag

    import BandwidthHero.ContractorErpTagsFixtures
    alias BandwidthHero.ContractorFixtures
    alias BandwidthHero.TagsFixtures

    @invalid_attrs %{contractor_id: nil, erp_tag_id: nil}

    setup do
      contractor = ContractorFixtures.contractor_fixture()
      erp_tag = TagsFixtures.erp_tag_fixture()
      %{contractor_id: contractor.id, erp_tag_id: erp_tag.id}
    end

    test "list_contractor_erp_tag/0 returns all contractor_erp_tag", context do
      contractor_erp_tag = contractor_erp_tag_fixture(context)
      assert ContractorErpTags.list_contractor_erp_tags() == [contractor_erp_tag]
    end

    test "get_contractor_erp_tag!/1 returns the contractor_erp_tag with given id", context do
      contractor_erp_tag = contractor_erp_tag_fixture(context)
      assert ContractorErpTags.get_contractor_erp_tag!(contractor_erp_tag.id) == contractor_erp_tag
    end

    test "create_contractor_erp_tag/1 with valid data creates a contractor_erp_tag", context do
      valid_attrs = Map.merge(context, %{projects: 42, years: 42})

      assert {:ok, %ContractorErpTag{} = contractor_erp_tag} = ContractorErpTags.create_contractor_erp_tag(valid_attrs)
      assert contractor_erp_tag.projects == 42
      assert contractor_erp_tag.years == 42
    end

    test "create_contractor_erp_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ContractorErpTags.create_contractor_erp_tag(@invalid_attrs)
    end

    test "update_contractor_erp_tag/2 with valid data updates the contractor_erp_tag", context do
      contractor_erp_tag = contractor_erp_tag_fixture(context)
      update_attrs = %{projects: 43, years: 43}

      assert {:ok, %ContractorErpTag{} = contractor_erp_tag} = ContractorErpTags.update_contractor_erp_tag(contractor_erp_tag, update_attrs)
      assert contractor_erp_tag.projects == 43
      assert contractor_erp_tag.years == 43
    end

    test "update_contractor_erp_tag/2 with invalid data returns error changeset", context do
      contractor_erp_tag = contractor_erp_tag_fixture(context)
      assert {:error, %Ecto.Changeset{}} = ContractorErpTags.update_contractor_erp_tag(contractor_erp_tag, @invalid_attrs)
      assert contractor_erp_tag == ContractorErpTags.get_contractor_erp_tag!(contractor_erp_tag.id)
    end

    test "delete_contractor_erp_tag/1 deletes the contractor_erp_tag", context  do
      contractor_erp_tag = contractor_erp_tag_fixture(context)
      assert {:ok, %ContractorErpTag{}} = ContractorErpTags.delete_contractor_erp_tag(contractor_erp_tag)
      assert_raise Ecto.NoResultsError, fn -> ContractorErpTags.get_contractor_erp_tag!(contractor_erp_tag.id) end
    end

    test "change_contractor_erp_tag/1 returns a contractor_erp_tag changeset", context do
      contractor_erp_tag = contractor_erp_tag_fixture(context)
      assert %Ecto.Changeset{} = ContractorErpTags.change_contractor_erp_tag(contractor_erp_tag)
    end
  end
end
