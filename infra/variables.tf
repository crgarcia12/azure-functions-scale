variable "prefix" {
  type    = string
  default = "crgar-legal"
}
variable "SSH_USERNAME" {
  type      = string
  sensitive = true
}
variable "SSH_PASSWORD" {
  type      = string
  sensitive = true
}