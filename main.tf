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
resource "okta_group" "test" {
  # (resource arguments)
}

resource "okta_group" "Staff" {
  name        = "Okta"
  description = "Staff group"
  skip_users  = true
}

#group rules#

resource "okta_group_rule" "Learner" {
  name              = "Learner"
  status            = "ACTIVE"
  group_assignments = [
    okta_group.Learner.id] #change me when copypasta#
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "String.stringContains(user.email,\".co.nz\")"
}

resource "okta_group_rule" "Staff2" {
  name              = "Staff"
  status            = "ACTIVE"
  group_assignments = [
    okta_group.Staff.id] #change me when copypasta#
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "String.stringContains(user.email,\".ac.nz\")"
}

#apps


resource "okta_app_saml" "learner_workspace2" {
    preconfigured_app = "google"
  label             = "Learner Google Workspace"
  status            = "ACTIVE"
  saml_version      = "2.0"
}

resource "okta_app_group_assignment" "learner_group_assignment" {
app_id = okta_app_saml.learner_workspace.id
group_id = okta_group.Learner.id
}

resource "okta_app_group_assignment" "staff_group_assignment" {
app_id = okta_app_saml.staff_workspace.id
group_id = okta_group.Staff.id
}

resource "okta_app_group_assignment" "staff_group_learner_assignment" {
app_id = okta_app_saml.learner_workspace.id
group_id = okta_group.Staff.id
}

