
# Multi-Project Cloud Armor Security Policy Management using Terraform

This terraform script will allow you to do the following - 

  **1.** Manage common Cloud Armor Policy rules across multiple GCP Projects.
  
  **2.** Manage GCP project specific Cloud Armor Policies.

Following types of rules can be configured using this terraform script - 

  * **Pre-Configured Rules:** These are based on pre-configured waf rules.
  * **Security Rules:** Allow or Deny traffic from list of IP addresses or IP adress ranges.
  * **Custom Rules:** You can create your own rules using Common Expression Language (CEL).
  * **Threat Intelligence Rules:** Add Rules based on threat intelligence. Managed protection plus subscription is needed to use this feature.


## 1. Pre-Requisites: 

  * Install "gcloud" cli
  * Install Terraform
  * Clone the Terraform scripts from this git repo to your local directory.

## 2. Authentication:

There are multiple ways to authenticate the API calls to GCP. Based on the use case you may opt for one of the following authentication methods - 


* If you want to keep things simple, you may use **"application-default login"** as shown in the following command - 

  ```gcloud auth application-default login```



* If you want to use this script for a single GCP project you may use service account based authentication -

  ```
  gcloud iam service-accounts create my-account
  gcloud iam service-accounts keys create key.json --iam-account=my-account@my-project.iam.gserviceaccount.com
  export GOOGLE_APPLICATION_CREDENTIALS=key.json
  ```

More Authentication options available at - https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication-configuration


## 3. Set the Variables:

Variables for this script are defined in 3 files - 

  * **terraform.tfvars:**  List of GCP Projects, and Security Policy Params.
  * **project_specific_rules.auto.tfvars:** List of unique rules mapped with the GCP Projects.
  * **common_rules.auto.tfvars:** List of common rules applicable to all the GCP projects defined in the "terraform.tfvars" files.

  Note: All the variables, and the data-strustrues are defined in the "variables.tf" file.


## 4. Initialize, Plan, and Apply:

Once you are done with the variable files, you can use "terraform init" command to install the Cloud Armor's "security_policy" module from Terraform repo. 

    terraform init
  
Create and varify the plan using "terraform plan" command - 

    terraform plan

Apply the changes to Cloud Armor using the "terraform apply" command - 

    terraform apply


