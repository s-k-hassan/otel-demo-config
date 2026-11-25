terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
  required_version = ">= 1.1.5"
}

provider "datadog" {
  api_key = var.datadogApiKey
  app_key = var.datadogAppKey
}
