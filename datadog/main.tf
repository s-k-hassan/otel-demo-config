### Datadog Custom Log Pipelines ###

resource "datadog_logs_custom_pipeline" "otelDemoRecommendation" {
  filter {
    query = "service:recommendation"
  }
  processor {
    grok_parser {
      source = "message"
      grok {
        support_rules = ""
        match_rules   = <<-EOT
						listRecommendations Receive ListRecommendations for product ids:\['%%{notSpace:product}', '%%{notSpace:product}', '%%{notSpace:product}', '%%{notSpace:product}', '%%{notSpace:product}'\]
						listRecommendationsDetailed %%{date("yyyy-MM-dd hh:mm:ss,SSS"):timestamp} %%{word:level} \[%%{word}\] \[%%{notSpace:logger.logsource}:%%{integer:logger.line}\] \[trace_id=%%{notSpace:trace.traceid} span_id=%%{notSpace:trace.spanid} resource.service.name=%%{word:service.name} trace_sampled=%%{word:trace.sampled}] - Receive ListRecommendations for product ids:\['%%{notSpace:product}', '%%{notSpace:product}', '%%{notSpace:product}', '%%{notSpace:product}', '%%{notSpace:product}'\]
						EOT
      }
      name       = "Log Parser for Recommendation Service"
      is_enabled = true
    }
  }
  name = "Otel Demo - Recommendation Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoCart" {
  filter {
    query = "service:cart"
  }
  processor {
    grok_parser {
      source = "message"
      grok {
        support_rules = ""
        match_rules   = <<-EOT
						addedItem %%{regex('[a-zA-Z]*'):cart.action}%%{regex('Async')} called with userId=%%{notSpace:cart.userid}, productId=%%{notSpace:cart.product.id}, quantity=%%{notSpace:cart.product.quantity}
						emptyCart %%{regex('[a-zA-Z]*'):cart.action}%%{regex('Async')} called with userId=%%{notSpace:cart.userid}
						valkeyGet %%{word:status}: %%{notSpace:log.loggerId}\[%%{notSpace:cart.cart.id}\]
						EOT
      }
      name       = "Log Parser for Cart Service"
      is_enabled = true
    }
  }
  name = "Otel Demo - Cart Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoAds" {
  filter {
    query = "service:ads"
  }
  processor {
    grok_parser {
      source = "message"
      grok {
        support_rules = ""
        match_rules   = <<-EOT
						targeting Targeted ad request received for \[%%{word:ad.targetedItem}\]
						targetedAdDetailed %%{date("yyyy-MM-dd hh:mm:ss"):timestamp} - %%{word}.%%{word:service.name} - Non-targeted ad request received, preparing random response. trace_id=%%{notSpace:trace.traceid} span_id=%%{notSpace:trace.spanid} trace_flags=%%{number:trace.flags}
						targetedAd %%{date("yyyy-MM-dd hh:mm:ss"):timestamp} - %%{word}.%%{word:service.name} - Targeted ad request received for \[%%{word:ad.targetedItem}\] trace_id=%%{notSpace:trace.traceid} span_id=%%{notSpace:trace.spanid} trace_flags=%%{number:trace.flags}
						EOT
      }
      name       = "Log Parser for Cart Service"
      is_enabled = true
    }
  }
  name = "Otel Demo - Ads Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoShipping" {
  filter {
    query = "service:shipping"
  }
  processor {
    grok_parser {
      source = "message"
      grok {
        support_rules = ""
        match_rules   = <<-EOT
						shippingSendQuoteLog %%{data}%%{date("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"):timestamp}%%{data} %%{word:level}%%{data}%%{regex("[a-z]{8}::[a-z_]*"):logger}%%{data} %%{notSpace:shipping.quote.action}ing Quote %%{data}dollars%%{data}=%%{data}%%{integer:shipping.quote.dollars} %%{data}cents%%{data}=%%{data}%%{integer:shipping.quote.cents}
						shippingRequestQuoteLog %%{data}%%{date("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"):timestamp}%%{data} %%{word:level}%%{data}%%{regex("[a-z]{8}::[a-z_]*::quote"):logger}%%{data} %%{notSpace:shipping.quote.action}ing quote %%{data}=%%{data}"%%{data:shipping.quote.requestUrl}"
						shippingTrackingId \[2m %%{date("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"):timestamp} \[0m \s+ \[32m\s+ %%{word:level}\[0m\s+ \[2m %%{notSpace:logger.name} \[0m \[2m: \[0m\s+%%{data:shipping.action}\s+ \[3mtracking_id \[0m \[2m= \[0m"%%{notSpace:shipping.tracking_id}"
						shippingFeatureFlag %%{regex("\\x1b?\\[2m")}%%{date("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"):timestamp}%%{regex("\\x1b\\[0m")} %%{regex("\\x1b\\[32m")} %%{word:level}%%{regex("\\x1b\\[0m")} %%{regex("\\x1b\\[2m")}%%{notSpace:service.name}%%{regex("\\x1b\\[0m\\x1b\\[2m:\\x1b\\[0m")} %%{regex("\\x1b\\[3m")}feature_flag_key%%{regex("\\x1b\\[0m\\x1b\\[2m=\\x1b\\[0m")}"%%{notSpace:feature_flag.action}" %%{regex("\\x1b\\[3m")}feature_flag_provider_name%%{regex("\\x1b\\[0m\\x1b\\[2m=\\x1b\\[0m")}"%%{notSpace:feature_flag.provider_name}" %%{regex("\\x1b\\[3m")}feature_flag_variant%%{regex("\\x1b\\[0m\\x1b\\[2m=\\x1b\\[0m")}"%%{notSpace:feature_flag.state}"
						EOT
      }
      name       = "Log Parser for Cart Service"
      is_enabled = true
    }
  }
  name = "Otel Demo - Shipping Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoImageProvider" {
  filter {
    query = "service:imageprovider"
  }
  processor {
    grok_parser {
      source = "message"
      grok {
        support_rules = ""
        match_rules   = <<-EOT
						httpAccessLog %%{regex("\\d{1,3}(?:\\.\\d{1,3}){3}"):network.client.ip} - - \[%%{date("dd/MMM/yyyy:HH:mm:ss Z"):timestamp}\] "%%{word:http.method} %%{notSpace:http.url} HTTP%%{notSpace:http.version}" %%{integer:http.status_code} %%{integer:http.response_size} "%%{notSpace:http.referer}" "%%{data:http.user_agent}"
						EOT
      }
      name       = "Log Parser for Image Provider Service"
      is_enabled = true
    }
  }
  name = "Otel Demo - Image Provider Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoQuote" {
  filter {
    query = "service:quote"
  }
  processor {
    attribute_remapper {
      sources              = ["context.total"]
      source_type          = "attribute"
      target               = "quote.value"
      target_type          = "attribute"
      target_format        = "string"
      preserve_source      = true
      override_on_conflict = false
      name                 = "sample attribute processor"
      is_enabled           = true
    }
  }
  name = "Otel Demo - Quote Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoFrontendProxy" {
  filter {
    query = "service:frontend-proxy"
  }
  processor {
    grok_parser {
      source = "message"
      grok {
        support_rules = ""
        match_rules   = <<-EOT
						proxyAccessLog \[%%{date("yyyy-MM-dd'T'HH:mm:ss.SSSZ"):timestamp}\] "%%{word:http.method} %%{notSpace:http.url} HTTP/%%{notSpace:http.version}" %%{integer:http.status_code} %%{notSpace:http.response_flags} %%{word:proxy.upstream_type} %%{notSpace:proxy.response_code_details} "%%{data:http.referer}" %%{integer:network.bytes_received} %%{integer:network.bytes_sent} %%{integer:duration.total_ms} %%{integer:duration.upstream_ms} "%%{data:request.forwarded_for}" "%%{data:http.useragent}" "%%{notSpace:request.id}" "%%{notSpace:upstream.host}" "%%{regex("[0-9]{1,3}(?:[.][0-9]{1,3}){3}"):upstream.address.ip}:%%{integer:upstream.address.port}" %%{notSpace:service.name} %%{regex("[0-9]{1,3}(?:[.][0-9]{1,3}){3}"):downstream.remote.ip}:%%{integer:downstream.remote.port} %%{regex("[0-9]{1,3}(?:[.][0-9]{1,3}){3}"):downstream.local.ip}:%%{integer:downstream.local.port} %%{regex("[0-9]{1,3}(?:[.][0-9]{1,3}){3}"):upstream.local.ip}:%%{integer:upstream.local.port} - -
						EOT
      }
      name       = "Log Parser for Frontend Proxy Service"
      is_enabled = true
    }
  }
  name = "Otel Demo - Frontend Proxy Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoFraudDetection" {
  filter {
    query = "service:fraud-detection"
  }
  processor {
    grok_parser {
      source = "message"
      grok {
        support_rules = ""
        match_rules   = <<-EOT
						fraudDetection Consumed record with orderId: %%{notSpace:frauddetection.orderid}, and updated total count to: %%{integer:frauddetection.detectioncount}
						fraudDetectionDetailed %%{date("yyyy-MM-dd HH:mm:ss"):timestamp} - fraud-detection - Consumed record with orderId: %%{notSpace:frauddetection.orderid}, and updated total count to: %%{integer:frauddetection.detectioncount} trace_id=%%{notSpace:trace.traceid} span_id=%%{notSpace:trace.spanid} trace_flags=%%{integer:trace.flagid}
						EOT
      }
      name       = "Log Parser for Fraud Detection Service"
      is_enabled = true
    }
  }
  name = "Otel Demo - Fraud Detection Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoKafka" {
  filter {
    query = "service:kafka"
  }
  name = "Otel Demo - Kafka Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoCheckout" {
  filter {
    query = "service:checkout"
  }
  name = "Otel Demo - Checkout Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoAccounting" {
  filter {
    query = "service:accounting"
  }
  processor {
    grok_parser {
      source = "message"
      grok {
        support_rules = ""
        match_rules   = <<-EOT
						orderDetails Order details: %%{data:order:json}\.
						EOT
      }
      name       = "Log Parser for Accounting Service"
      is_enabled = true
    }
  }
  name = "Otel Demo - Accounting Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoEmail" {
  filter {
    query = "service:email"
  }
  name = "Otel Demo - Email Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoValkeyCart" {
  filter {
    query = "service:valkey-cart"
  }
  name = "Otel Demo - Valkey Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
resource "datadog_logs_custom_pipeline" "otelDemoAstronomyDB" {
  filter {
    query = "service:astronomy-db"
  }
  name = "Otel Demo - AstronomyDB Service "
  tags = "application:otel-demo,terraform:true,team:otel-store-team"
}
