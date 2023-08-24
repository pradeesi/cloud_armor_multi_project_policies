
# Multi-Project Cloud Armor Security Policy Management using Terraform


## 1. Pre-Requisites: 

  * Install "gcloud" cli
  * Install Terraform
  * Close the Terraform scripts from git repo to the local directory.

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

Note: All the variables and various data-strustrues are defined in the "variables.tf" file.


## 4. Initialize, Plan, and Apply:

