terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.10"
    }
  }
}

# Configure the Okta Provider - API token set in env var.
provider "okta" {
  org_name  = "dev-00369028"
  api_token = "005ukqpj32AnM_jS748vd6AsWrOM295fSeqXze-Ont"
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

resource "okta_group" "Okta" {
  name        = "Okta"
  description = "Staff group"
  skip_users  = true
}

#group rules#

resource "okta_group_rule" "Learner" {
  name              = "Learner"
  status            = "ACTIVE"
  group_assignments = [
    "00g61ik7masTdAXzI5d7"] #change me when copypasta#
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "String.stringContains(user.email,\".co.nz\")"
}

resource "okta_group_rule" "Staff" {
  name              = "Staff"
  status            = "ACTIVE"
  group_assignments = [
    "00g62fdcthqnoyiKY5d7"] #change me when copypasta#
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "String.stringContains(user.email,\".ac.nz\")"
}

#apps

resource "okta_app_saml" "staff_workspace" {
    app_settings_json = <<JSON
{
    "groupFilter": "app1.*",
    "siteURL": "https://www.okta.com"
}
JSON
  label = "learner Google Workspace"
  preconfigured_app = "google"
  saml_version = "2.0"
  status = "ACTIVE"
  user_name_template = "$${source.login}"
  user_name_template_type = "BUILT_IN"
}

resource "okta_app_saml" "learner_workspace" {
  app_settings_json = <<JSON
{
    "groupFilter": "app1.*",
    "siteURL": "https://www.okta.com"
}
JSON
  label = "learner Google Workspace"
  preconfigured_app = "google"
  saml_version = "2.0"
  status = "ACTIVE"
  user_name_template = "$${source.login}"
  user_name_template_type = "BUILT_IN"
}

resource "okta_app_group_assignment" "learner_google_workspace" {
  app_id ="0oa64rn5riKzOvBnK5d7"
  group_id="00g61ik7masTdAXzI5d7"
}

resource "okta_app_group_assignment" "staff_google_workspace" {
  app_id ="0oa64a9c8cGY9to155d7"
  group_id="00g62fdcthqnoyiKY5d7"
}
resource "okta_app_group_assignment" "staff_to_learner" {
  app_id ="0oa64rn5riKzOvBnK5d7"
  group_id="00g62fdcthqnoyiKY5d7"
}
