/**
* 
* Author:                  Pradeep Singh
* Date:                    21 Aug 2023
* Terraform Ver:           v1.4.6
* Cloud Armor Module:      https://registry.terraform.io/modules/GoogleCloudPlatform/cloud-armor/google/latest#Rules
* Cloud Armor Module Ver:  v1.1
*
**/


project_specific_rules_list = [ 
        {
            gcp_project = "project-1"
            project_specific_custom_rules = {

                    throttle_specific_ip_region = {
                        action      = "throttle"
                        priority    = 23
                        description = "Throttle specific IP address in US Region"
                        expression  = <<-EOT
                            origin.region_code == "US" && inIpRange(origin.ip, '47.185.201.159/32')
                        EOT
                        rate_limit_options = {
                            exceed_action                        = "deny(502)"
                            rate_limit_http_request_count        = 10
                            rate_limit_http_request_interval_sec = 60
                        }
                    }
                }
            project_specific_pre_configured_rules = {}
            project_specific_security_rules = {}
            project_specific_threat_intelligence_rules = {}
        }, 

        {
            gcp_project = "project-2"
            project_specific_custom_rules = {}
            project_specific_pre_configured_rules = {}
            project_specific_security_rules = {
                    "rate_ban_project_actor3" = {
                        action        = "rate_based_ban"
                        priority      = 14
                        description   = "Rate based ban for address from project actor3 only if they cross banned threshold"
                        src_ip_ranges = ["190.217.68.213", "45.116.227.70", ]
                        rate_limit_options = {
                            exceed_action                        = "deny(502)"
                            rate_limit_http_request_count        = 10
                            rate_limit_http_request_interval_sec = 60
                            ban_duration_sec                     = 600
                            ban_http_request_count               = 1000
                            ban_http_request_interval_sec        = 300
                            enforce_on_key                       = "ALL"
                        }
                        }

                        "redirect_project_rd" = {
                            action        = "redirect"
                            priority      = 12
                            description   = "Redirect IP address from project RD"
                            src_ip_ranges = ["190.217.68.215", "45.116.227.99", ]
                            redirect_type = "EXTERNAL_302"
                            redirect_target = "https://www.example.com"
                        }
                }
            project_specific_threat_intelligence_rules = {}
        } 
]