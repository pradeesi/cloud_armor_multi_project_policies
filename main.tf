/**
* 
* Author:                  Pradeep Singh
* Date:                    21 Aug 2023
* Terraform Ver:           v1.4.6
* Cloud Armor Module:      https://registry.terraform.io/modules/GoogleCloudPlatform/cloud-armor/google/latest#Rules
* Cloud Armor Module Ver:  v1.1
*
**/


module "security_policy" {
  source = "GoogleCloudPlatform/cloud-armor/google"
  version = "1.1"

  # Iterate through all gcp projects
  for_each = toset(var.gcp_projects)
  project_id = each.value

  name                                 = var.security_policy_prams["name"]
  description                          = var.security_policy_prams["description"]
  default_rule_action                  = var.security_policy_prams["default_rule_action"]
  type                                 = "CLOUD_ARMOR"
  layer_7_ddos_defense_enable          = true
  layer_7_ddos_defense_rule_visibility = "STANDARD"

  # Custom Rules using CEL
  custom_rules = "${contains(var.project_specific_rules_list.*.gcp_project, each.value) ? merge((var.project_specific_rules_list[index(var.project_specific_rules_list.*.gcp_project, each.value)]).project_specific_custom_rules, var.common_custom_rules) : var.common_custom_rules}"

  # Pre-configured WAF Rules
  pre_configured_rules = "${contains(var.project_specific_rules_list.*.gcp_project, each.value) ? merge((var.project_specific_rules_list[index(var.project_specific_rules_list.*.gcp_project, each.value)]).project_specific_pre_configured_rules, var.common_pre_configured_rules ) : var.common_pre_configured_rules}"

  # Action against specific IP addresses or IP adress ranges
  security_rules = "${contains(var.project_specific_rules_list.*.gcp_project, each.value) ? merge((var.project_specific_rules_list[index(var.project_specific_rules_list.*.gcp_project, each.value)]).project_specific_security_rules, var.common_security_rules ) : var.common_security_rules}"

  # Threat Intelligence Rules
  threat_intelligence_rules = "${contains(var.project_specific_rules_list.*.gcp_project, each.value) ? merge((var.project_specific_rules_list[index(var.project_specific_rules_list.*.gcp_project, each.value)]).project_specific_threat_intelligence_rules, var.common_threat_intelligence_rules ) : var.common_threat_intelligence_rules}"
  
}


