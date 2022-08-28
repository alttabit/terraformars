terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.2"
    }
  }
}

# Configure the Okta Provider - API token set in env var.
provider "okta" {
  org_name  = "dev-00369028"
  api_token = "00H2OR5GqaMeNOtDXyGW7ZdZBLsCwZtiVWDLBNWHIS"
}

resource "okta_user" "terraform_application" {
  login = "svc_terraform@example.com"
  email = "svc_terraform@example.com"
  first_name = "Terraform"
  last_name = "Application Automation"
  admin_roles = [ "APP_ADMIN" ]
}

#groups#
resource "okta_group" "Learner" {
  name        = "Learner"
  description = "Student group for accessing learner workspace"
  skip_users  = true
}

resource "okta_group" "Staff" {
  name        = "Okta"
  description = "Staff group"
  skip_users  = true
}

#group rules#


#apps
resource "okta_app_saml" "staff_google_workspace" {
preconfigured_app = "google"
  label             = "staff google"
  status            = "ACTIVE"
  saml_version      = "2.0"
  skip_users  = true
}

resource "okta_app_saml" "learner_google_workspace" {
preconfigured_app = "google"
  label             = "lear google"
  status            = "ACTIVE"
  saml_version      = "2.0"
  domain            =  "google"
}

