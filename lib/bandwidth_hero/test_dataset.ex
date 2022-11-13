defmodule BandwidthHero.TestDataset do
  import BandwidthHero.TagsFixtures
  import BandwidthHero.IntegrationFixtures

  def seed() do
    all_valid_erp_tags_fixture()

    full_contractor(
      [
        [~D[2023-01-01], ~D[2023-06-30], 40],
        [~D[2023-07-01], ~D[2023-12-31], 20],
        [~D[2024-07-01], ~D[2024-12-31], 20]
      ],
      [["Learning", 3, 5]]
    )

    full_contractor(
      [
        [~D[2023-01-01], ~D[2023-06-30], 0],
        [~D[2023-07-01], ~D[2023-12-31], 40],
        [~D[2024-07-01], ~D[2024-12-31], 20]
      ],
      [["Learning", 3, 5], ["Career Development", 3, 2]]
    )

    full_contractor(
      [
        [~D[2023-01-01], ~D[2023-03-31], 0],
        [~D[2023-04-01], ~D[2023-06-30], 10],
        [~D[2024-07-01], ~D[2024-09-30], 30],
        [~D[2024-10-01], ~D[2024-12-31], 15]
      ],
      [["Goal Management", 3, 5], ["Career Development", 3, 2], ["Profile Management", 3, 2]]
    )
  end
end
