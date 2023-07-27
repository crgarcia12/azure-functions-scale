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