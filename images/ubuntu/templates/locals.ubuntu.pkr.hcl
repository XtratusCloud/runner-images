locals {
  image_properties_map = {
      "ubuntu22" = {
            publisher       = "canonical"
            offer           = "0001-com-ubuntu-server-jammy"
            sku             = "22_04-lts-gen2" ##XTRATUS
            os_disk_size_gb = coalesce(var.os_disk_size_gb, 75)
      },
      "ubuntu24" = {
            publisher       = "canonical"
            offer           = "ubuntu-24_04-lts"
            sku             = "server" ##XTRATUS
            os_disk_size_gb = coalesce(var.os_disk_size_gb, 75)
      }
  }

  image_properties = local.image_properties_map[var.image_os]
}
