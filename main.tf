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

resource "okta_group_rule" "staff" {
  name              = "staff"
  status            = "ACTIVE"
  group_assignments = [
    "00g61y3uc88TY2TQy5d7"] #change me when copypasta#
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "String.stringContains(user.email,\".ac.nz\")"
}

#apps

resource "okta_app_saml" "gworkspace" {
  label                    = "Google Workspace"
  sso_url                  = "https://dev-00369028.okta.com/app/google/exk5kydc8z9gMCWLJ5d7/sso/saml"
  recipient                = "uverse0.com"
  destination              = "uverse0.com"
  audience                 = "https://dev-00369028.okta.com/app/google/exk5kydc8z9gMCWLJ5d7/sso/samlaudience"
  subject_name_id_template = "$${user.userName}"
  subject_name_id_format   = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  response_signed          = true
  signature_algorithm      = "RSA_SHA256"
  digest_algorithm         = "SHA256"
  honor_force_authn        = false
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  attribute_statements {
    type         = "GROUP"
    name         = "groups"
    filter_type  = "REGEX"
    filter_value = ".*"
  }
}




