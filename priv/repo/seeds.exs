# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BandwidthHero.Repo.insert!(%BandwidthHero.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BandwidthHero.Repo
alias BandwidthHero.Tags.ErpTag

oracle = Repo.insert! %ErpTag{
  label: "Oracle",
  type: :vendor
}

cloud_appliations = Repo.insert! %ErpTag{
  label: "Platform",
  type: :platform,
  parent_erp_tag_id: oracle.id
}

hcm = Repo.insert! %ErpTag{
  label: "HCM",
  type: :pillar,
  parent_erp_tag_id: cloud_appliations.id
}

recruiting = Repo.insert! %ErpTag{
  label: "Recruiting",
  type: :module,
  parent_erp_tag_id: hcm.id
}
