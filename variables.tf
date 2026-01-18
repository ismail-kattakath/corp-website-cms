variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for kattakath.com"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "google_project_id" {
  description = "Google Cloud Project ID"
  type        = string
  default     = "709817050082"
}

variable "domain" {
  description = "Primary domain name"
  type        = string
  default     = "kattakath.com"
}
