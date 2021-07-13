terraform {
  required_version = ">= 0.15"
  experiments      = [module_variable_optional_attrs]

  backend "remote" {
    workspaces {
      name = "scaffoldly-bootstrap"
    }
  }
}

module "bootstrap" {
  source  = "scaffoldly/bootstrap/scaffoldly"
  version = "0.15.28-11"

  root_email   = var.ROOT_EMAIL
  github_token = var.BOOTSTRAP_GITHUB_TOKEN
  organization = var.BOOTSTRAP_ORGANIZATION

  auth_service = true

  stages = {
    nonlive = {
      domain           = "futz.dev"
      subdomain_suffix = "dev"
    }
    live = {
      domain = "futz.dev"
    }
  }

  public_websites = {
    angular = {
      template = "scaffoldly/web-angular-template"
    }
    cdn = {
      template = "scaffoldly/web-cdn-template"
    }
    jwt = {
      template = "scaffoldly/web-jwt-verifier-template"
    }
  }

  serverless_apis = {
    example = {
      template = "scaffoldly/sls-rest-api-template"
    }
  }
}
