mix bh.gen.live Tags ErpTag erp_tags label:string type:enum:vendor:system:pillar:feature
mix bh.gen.live Contractors Contractor contractors name:string title:string availability:enum:full:partial:none bandwidth:integer travel:enum:100%:75%:50%:25%:remote international_travel:enum:yes:no:maybe contract_type:enum:corp_to_corp:contract_w2:1099 laptop:enum:use_my_own:use_provided_laptop
mix bh.gen.live ContractorErpTags ContractorErpTag contractor_erp_tags years:integer projects:integer contractor_id:references:contractor erp_tag_id:references:erp_tag
mix bh.gen.live Experiences Experience experience label:string description:text from:date to:date
mix bh.gen.live Certificates Certificate certificate label:string description:text references:contractor
mix bh.gen.live Availabilities Availability availability from:date to:date contractor_id:references:contractor