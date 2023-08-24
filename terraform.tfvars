/**
* 
* Author:                  Pradeep Singh
* Date:                    21 Aug 2023
* Terraform Ver:           v1.4.6
* Cloud Armor Module:      https://registry.terraform.io/modules/GoogleCloudPlatform/cloud-armor/google/latest#Rules
* Cloud Armor Module Ver:  v1.1
*
**/


# GCP Project list
gcp_projects = ["project-1", "project-2"]


# Security Policy basic parameters
security_policy_prams = {
    "name" = "terraform-security-policy"
    "description" = "Security Policy - Created by Terraform"
    "default_rule_action" = "allow"
}