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
  api_token = "00nC6wVV6Jyn0xPNLGNaWTluK0Jt3rk2nhwPh7lIey"
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

resource "okta_group" "group34" {
  name        = "group34"
  description = "34groupth"
  skip_users  = true
}

resource "okta_group" "group34r57457" {
  name        = "group34457457"
  description = "34groupth"
  skip_users  = true
}

resource "okta_group" "group35" {
  name        = "group34"
  description = "34groupth"
  skip_users  = true
}

resource "okta_group" "group36" {
  name        = "group34"
  description = "34groupth"
  skip_users  = true
}

resource "okta_group" "group37" {
  name        = "group34"
  description = "34groupth"
  skip_users  = true
}

resource "okta_group" "Staff" {
  name        = "Okta"
  description = "Staff group"
  skip_users  = true
}

resource "okta_group" "Staff2232ghj4" {
  name        = "tesfghj3t group"
  description = "Staff group"
  skip_users  = true
}

#group rules#


#apps

resource "okta_app_saml" "learner2_google_workspace" {
preconfigured_app = "google"
  label             = "lear23wre google"
  status            = "ACTIVE"
  saml_version      = "2.0"
  app_settings_json = <<JSON
{
    "domain": "uverse0.com",
    "afwOnly": false
}
JSON
user_name_template = "$${fn:substringBefore(source.email, \"@\")}"
user_name_template_type = "BUILT_IN"
}

resource "okta_app_saml" "staff_google_workspace" {
   preconfigured_app = "google"
  label             = "stf_google_workspace"
  status            = "ACTIVE"
  saml_version      = "2.0"
  skip_users = true
  skip_groups = true
  app_settings_json = <<JSON
{
    "domain": "galaxi.uverse0.com",
    "afwOnly": false
}
JSON
user_name_template = "$${source.email}"
user_name_template_type = "BUILT_IN"
}