region                  = "us10"
globalaccount_subdomain = "ticrossa"
subaccount_name         = "Demo capGPT 2"
app_admins              = ["rui.nogueira@sap.com", "jeremias.roessler@sap.com"]
cloudfoundry_org_id = "$(terraform output cloudfoundry_org_id)"
cloudfoundry_space_id = "$(terraform output cloudfoundry_space_id)"
