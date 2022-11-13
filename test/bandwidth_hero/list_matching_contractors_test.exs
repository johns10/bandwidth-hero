defmodule BandwidthHero.ListMatchingContractorsTest do
  use BandwidthHero.DataCase

  alias BandwidthHero.ListMatchingContractors
  alias BandwidthHero.Opportunities

  import BandwidthHero.TagsFixtures

  import BandwidthHero.IntegrationFixtures

  def get_list_intersection(sets) do
    Enum.reduce(sets, [], fn set, sets ->
      {disjoined, joined} = Enum.split_with(sets, &MapSet.disjoint?(&1, set))
      [Enum.reduce(joined, set, &MapSet.union/2) | disjoined]
    end)
  end

  setup do
    all_valid_erp_tags_fixture()
  end

  describe "contractor with full availability" do
    setup do
      contractor =
        full_contractor(
          [[~D[2020-01-01], ~D[2020-06-30], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns in result", context do
      assert [context.contractor] == ListMatchingContractors.execute(context.opportunity)
    end
  end

  describe "contractor with previous adjacent availability" do
    setup do
      contractor =
        full_contractor(
          [[~D[2019-12-31], ~D[2020-01-01], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "does not return", context do
      assert [] == ListMatchingContractors.execute(context.opportunity)
    end
  end

  describe "contractor with following adjacent availability" do
    setup do
      contractor =
        full_contractor(
          [[~D[2020-07-01], ~D[2020-12-31], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "does not return", context do
      assert [] == ListMatchingContractors.execute(context.opportunity)
    end
  end

  describe "contractor with availability, but no hours" do
    setup do
      contractor =
        full_contractor(
          [[~D[2020-01-01], ~D[2020-06-30], 0]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns in result", context do
      assert [] == ListMatchingContractors.execute(context.opportunity)
    end
  end

  describe "contractor with previous overlapping availability" do
    setup do
      contractor =
        full_contractor(
          [[~D[2019-10-01], ~D[2020-03-31], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns in result", context do
      assert [context.contractor] == ListMatchingContractors.execute(context.opportunity)
    end
  end

  describe "contractor with following overlapping availability" do
    setup do
      contractor =
        full_contractor(
          [[~D[2020-03-31], ~D[2020-08-31], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns in result", context do
      assert [context.contractor] == ListMatchingContractors.execute(context.opportunity)
    end
  end

  describe "contractors availability contains project" do
    setup do
      contractor =
        full_contractor(
          [[~D[2019-12-01], ~D[2020-08-31], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns in result", context do
      assert [context.contractor] == ListMatchingContractors.execute(context.opportunity)
    end
  end

  describe "contractor with 1/3 matching availabilities" do
    setup do
      contractor =
        full_contractor(
          [
            [~D[2020-02-01], ~D[2020-03-31], 40],
            [~D[2020-04-01], ~D[2020-06-30], 0],
            [~D[2020-07-01], ~D[2020-09-01], 40]
          ],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "only returns matching availability in result", context do
      [contractor] = ListMatchingContractors.execute(context.opportunity)
      assert Enum.count(contractor.availabilities) == 1
    end
  end

  describe "contractors with no matching tags" do
    setup do
      contractor =
        full_contractor(
          [[~D[2020-01-01], ~D[2020-06-30], 40]],
          [["Career Development", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns in result", context do
      assert [] == ListMatchingContractors.execute(context.opportunity)
    end
  end

  describe "contractors with overlapping tags" do
    setup do
      contractor =
        full_contractor(
          [[~D[2020-01-01], ~D[2020-06-30], 40]],
          [["Learning", 3, 5], ["Career Development", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5], ["Journeys", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns only overlapping tags in result", %{
      contractor: %{id: contractor_id},
      opportunity: opportunity
    } do
      assert [contractor] = ListMatchingContractors.execute(opportunity)
      assert contractor.id == contractor_id

      [contractor_erp_tag] = contractor.contractor_erp_tags
      [opportunity_erp_tag | _] = opportunity.opportunity_erp_tags

      assert contractor_erp_tag.erp_tag_id == opportunity_erp_tag.erp_tag_id
    end
  end

  describe "100% availability score" do
    setup do
      contractor =
        full_contractor(
          [[~D[2019-01-01], ~D[2020-06-30], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns 100% availability", context do
      assert [%{availability_score: 1.0}] =
               [context.contractor]
               |> ListMatchingContractors.calculate_score(context.opportunity)
    end
  end

  describe "50% availability score" do
    setup do
      contractor =
        full_contractor(
          [[~D[2019-01-01], ~D[2020-03-31], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns correctly", context do
      assert [%{availability_score: 0.49723756906077354}] =
               [context.contractor]
               |> ListMatchingContractors.calculate_score(context.opportunity)
    end
  end

  describe "66% availability score" do
    setup do
      contractor =
        full_contractor(
          [[~D[2020-01-01], ~D[2020-03-31], 40], [~D[2020-04-01], ~D[2020-06-30], 20]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns correctly", context do
      assert [%{availability_score: 0.7458563535911604}] =
               [context.contractor]
               |> ListMatchingContractors.calculate_score(context.opportunity)
    end
  end

  describe "0% availability score" do
    setup do
      contractor =
        full_contractor(
          [[~D[2020-01-01], ~D[2020-06-30], 0]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns correctly", context do
      assert [%{availability_score: 0.0}] =
               [context.contractor]
               |> ListMatchingContractors.calculate_score(context.opportunity)
    end
  end

  describe "100% skill score" do
    setup do
      contractor =
        full_contractor(
          [[~D[2019-01-01], ~D[2020-06-30], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns 100% skill", context do
      assert [%{skill_score: 1.0}] =
               [context.contractor]
               |> ListMatchingContractors.calculate_score(context.opportunity)
    end
  end

  describe "50% skill score" do
    setup do
      contractor =
        full_contractor(
          [[~D[2019-01-01], ~D[2020-06-30], 40]],
          [["Learning", 3, 5]]
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Learning", 3, 5], ["Career Development", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns 100% skill", context do
      assert [%{skill_score: 0.5}] =
               [context.contractor]
               |> ListMatchingContractors.calculate_score(context.opportunity)
    end
  end

  describe "0% skill score" do
    setup do
      contractor =
        full_contractor(
          [[~D[2019-01-01], ~D[2020-06-30], 40]],
          []
        )

      opportunity =
        full_opportunity(
          %{from_date: ~D[2020-01-01], to_date: ~D[2020-06-30]},
          [["Career Development", 3, 5]]
        )

      opportunity =
        Opportunities.get_opportunity!(opportunity.id, preloads: [opportunity_erp_tags: true])

      %{contractor: contractor, opportunity: opportunity}
    end

    test "returns 0% skill", context do
      assert [%{skill_score: 0.0}] =
               [context.contractor]
               |> ListMatchingContractors.calculate_score(context.opportunity)
    end
  end
end
