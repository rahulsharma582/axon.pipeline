variable "resource_groups" {
  description = "Map of resource group configurations to create"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
}
