defmodule BandwidthHero.SourcerUsersTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.SourcerUsers

  describe "sourcer_users" do
    alias BandwidthHero.SourcerUsers.SourcerUser

    import BandwidthHero.SourcerUsersFixtures
    import BandwidthHero.SourcersFixtures

    setup do
      user =
        %BandwidthHero.Accounts.User{
          email: "test@test.com",
          password: "asdfasdfasdfasdf",
          hashed_password: "asdfasdfasdfasdf"
        }
        |> BandwidthHero.Repo.insert!()

      sourcer = sourcer_fixture()

      %{user: user, sourcer: sourcer}
    end

    @invalid_attrs %{position: nil, user_id: nil}

    test "list_sourcer_users/0 returns all sourcer_users", context do
      %{user: user, sourcer: sourcer} = context
      sourcer_user = sourcer_user_fixture(%{user_id: user.id, sourcer_id: sourcer.id})
      assert SourcerUsers.list_sourcer_users() == [sourcer_user]
    end

    test "get_sourcer_user!/1 returns the sourcer_user with given id", context do
      %{user: user, sourcer: sourcer} = context
      sourcer_user = sourcer_user_fixture(%{user_id: user.id, sourcer_id: sourcer.id})
      assert SourcerUsers.get_sourcer_user!(sourcer_user.id) == sourcer_user
    end

    test "create_sourcer_user/1 with valid data creates a sourcer_user", context do
      %{user: user, sourcer: sourcer} = context
      valid_attrs = %{position: "some position", user_id: user.id, sourcer_id: sourcer.id}

      assert {:ok, %SourcerUser{} = sourcer_user} = SourcerUsers.create_sourcer_user(valid_attrs)
      assert sourcer_user.position == "some position"
    end

    test "create_sourcer_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SourcerUsers.create_sourcer_user(@invalid_attrs)
    end

    test "update_sourcer_user/2 with valid data updates the sourcer_user", context do
      %{user: user, sourcer: sourcer} = context
      sourcer_user = sourcer_user_fixture(%{user_id: user.id, sourcer_id: sourcer.id})
      update_attrs = %{position: "some updated position"}

      assert {:ok, %SourcerUser{} = sourcer_user} =
               SourcerUsers.update_sourcer_user(sourcer_user, update_attrs)

      assert sourcer_user.position == "some updated position"
    end

    test "update_sourcer_user/2 with invalid data returns error changeset", context do
      %{user: user, sourcer: sourcer} = context
      sourcer_user = sourcer_user_fixture(%{user_id: user.id, sourcer_id: sourcer.id})

      assert {:error, %Ecto.Changeset{}} =
               SourcerUsers.update_sourcer_user(sourcer_user, @invalid_attrs)

      assert sourcer_user == SourcerUsers.get_sourcer_user!(sourcer_user.id)
    end

    test "delete_sourcer_user/1 deletes the sourcer_user", context do
      %{user: user, sourcer: sourcer} = context
      sourcer_user = sourcer_user_fixture(%{user_id: user.id, sourcer_id: sourcer.id})
      assert {:ok, %SourcerUser{}} = SourcerUsers.delete_sourcer_user(sourcer_user)
      assert_raise Ecto.NoResultsError, fn -> SourcerUsers.get_sourcer_user!(sourcer_user.id) end
    end

    test "change_sourcer_user/1 returns a sourcer_user changeset", context do
      %{user: user, sourcer: sourcer} = context
      sourcer_user = sourcer_user_fixture(%{user_id: user.id, sourcer_id: sourcer.id})
      assert %Ecto.Changeset{} = SourcerUsers.change_sourcer_user(sourcer_user)
    end
  end
end
