module "datadogConfig" {
  source        = "./datadog"
  datadogApiKey = var.datadogApiKey
  datadogAppKey = var.datadogAppKey
}
