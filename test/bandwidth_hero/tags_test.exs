defmodule BandwidthHero.TagsTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.Tags

  describe "erp_tag" do
    alias BandwidthHero.Tags.ErpTag

    import BandwidthHero.TagsFixtures

    @invalid_attrs %{label: nil}

    test "list_erp_tag/0 returns all erp_tag" do
      erp_tag = erp_tag_fixture()
      assert Tags.list_erp_tags() == [erp_tag]
    end

    test "get_erp_tag!/1 returns the erp_tag with given id" do
      erp_tag = erp_tag_fixture()
      assert Tags.get_erp_tag!(erp_tag.id) == erp_tag
    end

    test "create_erp_tag/1 with valid data creates a erp_tag" do
      valid_attrs = %{label: "some label"}

      assert {:ok, %ErpTag{} = erp_tag} = Tags.create_erp_tag(valid_attrs)
      assert erp_tag.label == "some label"
    end

    test "create_erp_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tags.create_erp_tag(@invalid_attrs)
    end

    test "update_erp_tag/2 with valid data updates the erp_tag" do
      erp_tag = erp_tag_fixture()
      update_attrs = %{label: "some updated label"}

      assert {:ok, %ErpTag{} = erp_tag} = Tags.update_erp_tag(erp_tag, update_attrs)
      assert erp_tag.label == "some updated label"
    end

    test "update_erp_tag/2 with invalid data returns error changeset" do
      erp_tag = erp_tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Tags.update_erp_tag(erp_tag, @invalid_attrs)
      assert erp_tag == Tags.get_erp_tag!(erp_tag.id)
    end

    test "delete_erp_tag/1 deletes the erp_tag" do
      erp_tag = erp_tag_fixture()
      assert {:ok, %ErpTag{}} = Tags.delete_erp_tag(erp_tag)
      assert_raise Ecto.NoResultsError, fn -> Tags.get_erp_tag!(erp_tag.id) end
    end

    test "change_erp_tag/1 returns a erp_tag changeset" do
      erp_tag = erp_tag_fixture()
      assert %Ecto.Changeset{} = Tags.change_erp_tag(erp_tag)
    end
  end
end
