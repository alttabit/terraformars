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



resource "okta_app_saml" "learner2_google_workspace" {
preconfigured_app = "google"
  label             = "lear23wre google"
  status            = "ACTIVE"
  saml_version      = "2.0"
    sso_url                  = "https://example.com"
  recipient                = "https://example.com"
  destination              = "https://example.com"
  audience                 = "https://example.com/audience"
    subject_name_id_template = "$${user.userName}"
  subject_name_id_format   = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  response_signed          = true
  signature_algorithm      = "RSA_SHA256"
  digest_algorithm         = "SHA256"
  honor_force_authn        = false
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

}