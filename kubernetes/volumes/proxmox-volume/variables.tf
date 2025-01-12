variable "storage" {
  type    = string
}

variable "vm_id" {
  type = number
}

variable "name" {
  type = string
}

variable "size" {
  type = number
}

variable "format" {
  type    = string
  default = "raw"
}

variable "connection" {
  type = object({
    user        = string
    private_key = string
    host        = string
  })
  sensitive = true
}
