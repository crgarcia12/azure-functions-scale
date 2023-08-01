################################
#         Generics
################################

variable "prefix" {
  description = "prefix"
  type        = string
}

variable "location" {
  description = "Location"
  type        = string
}

variable "resource_group_name" {
  description = "RG Name"
  type        = string
}

variable "storage_name" {
  description = "Azure Storage Account Name"
  type        = string
}

variable "storage_key" {
  description = "Azure Storage Key"
  type        = string
}
variable "appinsights_key" {
  description = "value of the appinsights key"
  type        = string
}

variable "appinsights_connectionstring" {
  description = "value of the appinsights connectionstring"
  type        = string
}

variable "acr_url" {
  description = "value of the acr url"
  type        = string
}

variable "acr_id" {
  description = "value of the acr id"
  type        = string
}

variable "acr_username" {
  description = "value of the acr username"
  type        = string
}

variable "acr_password" {
  description = "value of the acr password"
  type        = string
}