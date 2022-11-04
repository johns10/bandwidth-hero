defmodule BandwidthHero.ExperiencesTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.Experiences

  describe "experience" do
    alias BandwidthHero.Experiences.Experience

    import BandwidthHero.ExperiencesFixtures

    @invalid_attrs %{description: nil, from: nil, label: nil, to: nil}

    test "list_experiences/0 returns all experience" do
      experience = experience_fixture()
      assert Experiences.list_experiences() == [experience]
    end

    test "get_experience!/1 returns the experience with given id" do
      experience = experience_fixture()
      assert Experiences.get_experience!(experience.id) == experience
    end

    test "create_experience/1 with valid data creates a experience" do
      valid_attrs = %{description: "some description", from: ~D[2022-10-29], label: "some label", to: ~D[2022-10-29]}

      assert {:ok, %Experience{} = experience} = Experiences.create_experience(valid_attrs)
      assert experience.description == "some description"
      assert experience.from == ~D[2022-10-29]
      assert experience.label == "some label"
      assert experience.to == ~D[2022-10-29]
    end

    test "create_experience/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Experiences.create_experience(@invalid_attrs)
    end

    test "update_experience/2 with valid data updates the experience" do
      experience = experience_fixture()
      update_attrs = %{description: "some updated description", from: ~D[2022-10-30], label: "some updated label", to: ~D[2022-10-30]}

      assert {:ok, %Experience{} = experience} = Experiences.update_experience(experience, update_attrs)
      assert experience.description == "some updated description"
      assert experience.from == ~D[2022-10-30]
      assert experience.label == "some updated label"
      assert experience.to == ~D[2022-10-30]
    end

    test "update_experience/2 with invalid data returns error changeset" do
      experience = experience_fixture()
      assert {:error, %Ecto.Changeset{}} = Experiences.update_experience(experience, @invalid_attrs)
      assert experience == Experiences.get_experience!(experience.id)
    end

    test "delete_experience/1 deletes the experience" do
      experience = experience_fixture()
      assert {:ok, %Experience{}} = Experiences.delete_experience(experience)
      assert_raise Ecto.NoResultsError, fn -> Experiences.get_experience!(experience.id) end
    end

    test "change_experience/1 returns a experience changeset" do
      experience = experience_fixture()
      assert %Ecto.Changeset{} = Experiences.change_experience(experience)
    end
  end
end
