/**
* 
* Author:                  Pradeep Singh
* Date:                    21 Aug 2023
* Terraform Ver:           v1.4.6
* Cloud Armor Module:      https://registry.terraform.io/modules/GoogleCloudPlatform/cloud-armor/google/latest#Rules
* Cloud Armor Module Ver:  v1.1
*
**/


common_pre_configured_rules = {

    "sqli_sensitivity_level_4" = {
        action          = "deny(502)"
        priority        = 1
        target_rule_set = "sqli-v33-stable"
        }

    "php-stable_level_0_with_include" = {
        action                  = "deny(502)"
        priority                = 3
        description             = "PHP Sensitivity Level 0 with included rules"
        target_rule_set         = "php-v33-stable"
        include_target_rule_ids = ["owasp-crs-v030301-id933190-php", "owasp-crs-v030301-id933111-php"]
        }
    }

common_custom_rules = {

    deny_specific_regions = {
        action      = "deny(502)"
        priority    = 21
        description = "Deny specific Regions"
        expression  = <<-EOT
            '[AU,BE]'.contains(origin.region_code)
        EOT
        }
    }


common_security_rules = {

    "deny_project_bad_actor1" = {
        action        = "deny(502)"
        priority      = 11
        description   = "Deny Malicious IP address from project bad_actor1"
        src_ip_ranges = ["190.217.68.211/32", "45.116.227.68/32", "103.43.141.122", "123.11.215.36", "123.11.215.37", ]
        preview       = true
        }
    }


common_threat_intelligence_rules = {}