/**
* 
* Author:                  Pradeep Singh
* Date:                    21 Aug 2023
* Terraform Ver:           v1.4.6
* Cloud Armor Module:      https://registry.terraform.io/modules/GoogleCloudPlatform/cloud-armor/google/latest#Rules
* Cloud Armor Module Ver:  v1.1
*
**/


# Variable Definitions

variable "gcp_projects" {
        type = list(string)
    }


variable "security_policy_prams" {
  type = map
  default = {
    "name" = "terraform-security-policy"
    "description" = "Security Policy - Created by Terraform"
    "default_rule_action" = "allow"
  }
}

variable "common_custom_rules" {
        type = map(object({
            action          = string
            priority        = number
            description     = optional(string)
            preview         = optional(bool, false)
            expression      = string
            redirect_type   = optional(string, null)
            redirect_target = optional(string, null)
            rate_limit_options = optional(object({
            enforce_on_key      = optional(string)
            enforce_on_key_name = optional(string)
            enforce_on_key_configs = optional(list(object({
                enforce_on_key_name = optional(string)
                enforce_on_key_type = optional(string)
            })))
            exceed_action                        = optional(string)
            rate_limit_http_request_count        = optional(number)
            rate_limit_http_request_interval_sec = optional(number)
            ban_duration_sec                     = optional(number)
            ban_http_request_count               = optional(number)
            ban_http_request_interval_sec        = optional(number)
            }),
            {})
            header_action = optional(list(object({
            header_name  = optional(string)
            header_value = optional(string)
            })), [])
        }))

        default = {}
    }


variable "common_pre_configured_rules" {
        type = map(object({
            action                  = string
            priority                = number
            description             = optional(string)
            preview                 = optional(bool, false)
            redirect_type           = optional(string, null)
            redirect_target         = optional(string, null)
            target_rule_set         = string
            sensitivity_level       = optional(number, 4)
            include_target_rule_ids = optional(list(string), [])
            exclude_target_rule_ids = optional(list(string), [])
            rate_limit_options = optional(object({
                enforce_on_key      = optional(string)
                enforce_on_key_name = optional(string)
                enforce_on_key_configs = optional(list(object({
                enforce_on_key_name = optional(string)
                enforce_on_key_type = optional(string)
                })))
                exceed_action                        = optional(string)
                rate_limit_http_request_count        = optional(number)
                rate_limit_http_request_interval_sec = optional(number)
                ban_duration_sec                     = optional(number)
                ban_http_request_count               = optional(number)
                ban_http_request_interval_sec        = optional(number)
            }), {})

            header_action = optional(list(object({
                header_name  = optional(string)
                header_value = optional(string)
            })), [])

            preconfigured_waf_config_exclusion = optional(object({
                target_rule_set = string
                target_rule_ids = optional(list(string), [])
                request_header = optional(list(object({
                operator = string
                value    = optional(string)
                })))
                request_cookie = optional(list(object({
                operator = string
                value    = optional(string)
                })))
                request_uri = optional(list(object({
                operator = string
                value    = optional(string)
                })))
                request_query_param = optional(list(object({
                operator = string
                value    = optional(string)
                })))
            }), { target_rule_set = null })
        }))

        default = {}
    
    }


variable "common_security_rules" {
        type = map(object({
            action          = string
            priority        = number
            description     = optional(string)
            preview         = optional(bool, false)
            redirect_type   = optional(string, null)
            redirect_target = optional(string, null)
            src_ip_ranges   = list(string)
            rate_limit_options = optional(object({
            enforce_on_key      = optional(string)
            enforce_on_key_name = optional(string)
            enforce_on_key_configs = optional(list(object({
                enforce_on_key_name = optional(string)
                enforce_on_key_type = optional(string)
            })))
            exceed_action                        = optional(string)
            rate_limit_http_request_count        = optional(number)
            rate_limit_http_request_interval_sec = optional(number)
            ban_duration_sec                     = optional(number)
            ban_http_request_count               = optional(number)
            ban_http_request_interval_sec        = optional(number)
            }),
            {})
            header_action = optional(list(object({
            header_name  = optional(string)
            header_value = optional(string)
            })), [])
        }))

        default = {}
    }


variable "common_threat_intelligence_rules" {
        type = map(object({
            action      = string
            priority    = number
            description = optional(string)
            preview     = optional(bool, false)
            feed        = string
            exclude_ip  = optional(string)
            rate_limit_options = optional(object({
            enforce_on_key      = optional(string)
            enforce_on_key_name = optional(string)
            enforce_on_key_configs = optional(list(object({
                enforce_on_key_name = optional(string)
                enforce_on_key_type = optional(string)
            })))
            exceed_action                        = optional(string)
            rate_limit_http_request_count        = optional(number)
            rate_limit_http_request_interval_sec = optional(number)
            ban_duration_sec                     = optional(number)
            ban_http_request_count               = optional(number)
            ban_http_request_interval_sec        = optional(number)
            }),
            {})
            header_action = optional(list(object({
            header_name  = optional(string)
            header_value = optional(string)
            })), [])
        }))

        default = {}
    } 




variable "project_specific_rules_list" {
        type = list(object({
            gcp_project = string
            project_specific_custom_rules = map(object({
                                                action          = string
                                                priority        = number
                                                description     = optional(string)
                                                preview         = optional(bool, false)
                                                expression      = string
                                                redirect_type   = optional(string, null)
                                                redirect_target = optional(string, null)
                                                rate_limit_options = optional(object({
                                                enforce_on_key      = optional(string)
                                                enforce_on_key_name = optional(string)
                                                enforce_on_key_configs = optional(list(object({
                                                    enforce_on_key_name = optional(string)
                                                    enforce_on_key_type = optional(string)
                                                })))
                                                exceed_action                        = optional(string)
                                                rate_limit_http_request_count        = optional(number)
                                                rate_limit_http_request_interval_sec = optional(number)
                                                ban_duration_sec                     = optional(number)
                                                ban_http_request_count               = optional(number)
                                                ban_http_request_interval_sec        = optional(number)
                                                }),
                                                {})
                                                header_action = optional(list(object({
                                                header_name  = optional(string)
                                                header_value = optional(string)
                                                })), [])
                                            }))

                                       

            project_specific_pre_configured_rules = map(object({
                                                action                  = string
                                                priority                = number
                                                description             = optional(string)
                                                preview                 = optional(bool, false)
                                                redirect_type           = optional(string, null)
                                                redirect_target         = optional(string, null)
                                                target_rule_set         = string
                                                sensitivity_level       = optional(number, 4)
                                                include_target_rule_ids = optional(list(string), [])
                                                exclude_target_rule_ids = optional(list(string), [])
                                                rate_limit_options = optional(object({
                                                enforce_on_key      = optional(string)
                                                enforce_on_key_name = optional(string)
                                                enforce_on_key_configs = optional(list(object({
                                                    enforce_on_key_name = optional(string)
                                                    enforce_on_key_type = optional(string)
                                                })))
                                                exceed_action                        = optional(string)
                                                rate_limit_http_request_count        = optional(number)
                                                rate_limit_http_request_interval_sec = optional(number)
                                                ban_duration_sec                     = optional(number)
                                                ban_http_request_count               = optional(number)
                                                ban_http_request_interval_sec        = optional(number)
                                                }), {})

                                                header_action = optional(list(object({
                                                header_name  = optional(string)
                                                header_value = optional(string)
                                                })), [])

                                                preconfigured_waf_config_exclusion = optional(object({
                                                target_rule_set = string
                                                target_rule_ids = optional(list(string), [])
                                                request_header = optional(list(object({
                                                    operator = string
                                                    value    = optional(string)
                                                })))
                                                request_cookie = optional(list(object({
                                                    operator = string
                                                    value    = optional(string)
                                                })))
                                                request_uri = optional(list(object({
                                                    operator = string
                                                    value    = optional(string)
                                                })))
                                                request_query_param = optional(list(object({
                                                    operator = string
                                                    value    = optional(string)
                                                })))
                                                }), { target_rule_set = null })

                                        }))

            project_specific_security_rules = map(object({
                                                action          = string
                                                priority        = number
                                                description     = optional(string)
                                                preview         = optional(bool, false)
                                                redirect_type   = optional(string, null)
                                                redirect_target = optional(string, null)
                                                src_ip_ranges   = list(string)
                                                rate_limit_options = optional(object({
                                                enforce_on_key      = optional(string)
                                                enforce_on_key_name = optional(string)
                                                enforce_on_key_configs = optional(list(object({
                                                    enforce_on_key_name = optional(string)
                                                    enforce_on_key_type = optional(string)
                                                })))
                                                exceed_action                        = optional(string)
                                                rate_limit_http_request_count        = optional(number)
                                                rate_limit_http_request_interval_sec = optional(number)
                                                ban_duration_sec                     = optional(number)
                                                ban_http_request_count               = optional(number)
                                                ban_http_request_interval_sec        = optional(number)
                                                }),
                                                {})
                                                header_action = optional(list(object({
                                                header_name  = optional(string)
                                                header_value = optional(string)
                                                })), [])
                                        }))

            project_specific_threat_intelligence_rules = map(object({
                                                action      = string
                                                priority    = number
                                                description = optional(string)
                                                preview     = optional(bool, false)
                                                feed        = string
                                                exclude_ip  = optional(string)
                                                rate_limit_options = optional(object({
                                                enforce_on_key      = optional(string)
                                                enforce_on_key_name = optional(string)
                                                enforce_on_key_configs = optional(list(object({
                                                    enforce_on_key_name = optional(string)
                                                    enforce_on_key_type = optional(string)
                                                })))
                                                exceed_action                        = optional(string)
                                                rate_limit_http_request_count        = optional(number)
                                                rate_limit_http_request_interval_sec = optional(number)
                                                ban_duration_sec                     = optional(number)
                                                ban_http_request_count               = optional(number)
                                                ban_http_request_interval_sec        = optional(number)
                                                }),
                                                {})
                                                header_action = optional(list(object({
                                                header_name  = optional(string)
                                                header_value = optional(string)
                                                })), [])
                                        }))

             }))

        
        default = [ {
            gcp_project = ""
            project_specific_custom_rules = {}
            project_specific_pre_configured_rules = {}
            project_specific_security_rules = {}
            project_specific_threat_intelligence_rules = {}
        } ]

    }
