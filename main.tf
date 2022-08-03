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

resource "okta_group" "Learner" {
  name        = "Learner"
  description = "Student group for accessing learner workspace"
  skip_users  = true
}

resource "okta_group_rule" "Learner" {
  name              = "Learner"
  status            = "ACTIVE"
  group_assignments = [
    "00g61ik7masTdAXzI5d7"]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "String.startsWith(user.userType,\"Student\")"
}