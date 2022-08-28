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
 metadata = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><md:EntityDescriptor entityID=\"google.com/a/galaxy.uverse0.com\" xmlns:md=\"urn:oasis:names:tc:SAML:2.0:metadata\"><md:IDPSSODescriptor WantAuthnRequestsSigned=\"false\" protocolSupportEnumeration=\"urn:oasis:names:tc:SAML:2.0:protocol\"><md:KeyDescriptor use=\"signing\"><ds:KeyInfo xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:X509Data><ds:X509Certificate>MIIDqDCCApCgAwIBAgIGAYKLQRDhMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG\nA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU\nMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0wMDM2OTAyODEcMBoGCSqGSIb3DQEJ\nARYNaW5mb0Bva3RhLmNvbTAeFw0yMjA4MTEwNDUzMzNaFw0zMjA4MTEwNDU0MzNaMIGUMQswCQYD\nVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG\nA1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0wMDM2OTAyODEc\nMBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC\nggEBANEBj80iBLdqLHmYggfM5VE/JNgg1ucYTNffLnDoady+Ux4imNbjfUi5sEIdIOapByVTHzRu\n3JBiol34SagUhjJkucLK5Mf4BszcICy3bqQpBqSOPlyLp5fT4VdTYzOB4ud20n3sX+mHfNJNFB7O\nAje47frVITzBwqTFuTvI7Agh1wkFiVcMkMeYeiDef3qGNWoMq0wKhHcAPxTG0c5FUKzyJ3Va9GPZ\nqJuFHvHGOTQtmY3wB2jcjp3gga+PQfI6XY/TV+j5P+FD1OsQfYTezj7w7Qx3I4dqpPHgOzA+cVfL\nLtBmHfZF1XuNT5dyQjSQu4cgQths1c/8yiTroPb0f+0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA\nB87PQrL5yYp9HvaOu10zZv8cK+hExc6Dm5SsxOFhr4QYnfgs2UJzPw4CzYTMqfKIbf69rWbOwpxv\nZ463161C5WW+nJufo0WC5KA93rnPGqWGStdtQlEdOPuMKvWX+KS8efE8p8vTLULXNpAz0LYRacPB\nm1a7CpsEbdA/KEGCOFEy5h2CujgWaUMJI9+YoBMvJsXhDZeaQ31khu6kLjbSgXar4rwgqV2FLG9G\n4zGxJCbOQ28vQS46FZJI9ZlJOH8AIRhWJDzzLAH58b9idliSR6vpQmsNilLCQx2cyMRkafYcAx9+\nzAJIs7G9e/8Kf7brXRcDrV/e6o8scx1zNemJmA==</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:2.0:nameid-format:email</md:NameIDFormat><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:SingleSignOnService Binding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\" Location=\"https://dev-00369028.okta.com/app/google/exk64sf8txGRfotVo5d7/sso/saml\"/><md:SingleSignOnService Binding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect\" Location=\"https://dev-00369028.okta.com/app/google/exk64sf8txGRfotVo5d7/sso/saml\"/></md:IDPSSODescriptor></md:EntityDescriptor>"
}

