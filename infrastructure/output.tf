output "application_url" {
  value       = module.alb_client.dns_alb
  description = "url to access the deployed app"
}

output "swagger_endpoint" {
  value       = "${module.alb_server.dns_alb}/api/docs"
  description = "url to access the swagger documentation"
}
