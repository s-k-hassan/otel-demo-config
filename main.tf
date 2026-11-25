module "datadog" {
  source        = "./datadog"
  datadogApiKey = var.datadogApiKey
  datadogAppKey = var.datadogAppKey
}
