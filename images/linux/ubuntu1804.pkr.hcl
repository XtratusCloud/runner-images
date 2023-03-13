# Read the variables type constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
variable "allowed_inbound_ip_addresses" {
  type    = list(string)
  default = []
}

variable "build_resource_group_name" {
  type    = string
  default = "${env("BUILD_RESOURCE_GROUP_NAME")}"
}

variable "capture_name_prefix" {
  type    = string
  default = "packer"
}

variable "client_cert_path" {
  type    = string
  default = "${env("ARM_CLIENT_CERT_PATH")}"
}

variable "client_id" {
  type    = string
  default = "${env("ARM_CLIENT_ID")}"
}

variable "client_secret" {
  type      = string
  default   = "${env("ARM_CLIENT_SECRET")}"
  sensitive = true
}

variable "dockerhub_login" {
  type    = string
  default = "${env("DOCKERHUB_LOGIN")}"
}

variable "dockerhub_password" {
  type    = string
  default = "${env("DOCKERHUB_PASSWORD")}"
}

variable "helper_script_folder" {
  type    = string
  default = "/imagegeneration/helpers"
}

variable "image_folder" {
  type    = string
  default = "/imagegeneration"
}

variable "image_gallery_name" {
  type    = string
  default = "${env("IMAGE_GALLERY_NAME")}"
}

variable "image_gallery_regions" {
  type    = string
  default = "${env("IMAGE_GALLERY_REGIONS")}"
}

variable "image_gallery_replication" {
  type    = string
  default = "${env("IMAGE_GALLERY_REPLICATION")}"
}

variable "image_gallery_resourceId" {
  type    = string
  default = "${env("IMAGE_GALLERY_RESOURCEID")}"
}

variable "image_gallery_resource_group" {
  type    = string
  default = "${env("IMAGE_GALLERY_RESOURCE_GROUP")}"
}

variable "image_gallery_subscription" {
  type    = string
  default = "${env("IMAGE_GALLERY_SUBSCRIPTION")}"
}

variable "image_os" {
  type    = string
  default = "ubuntu18"
}

variable "image_version" {
  type    = string
  default = "dev"
}

variable "imagedata_file" {
  type    = string
  default = "/imagegeneration/imagedata.json"
}

variable "installer_script_folder" {
  type    = string
  default = "/imagegeneration/installers"
}

variable "location" {
  type    = string
  default = "${env("ARM_RESOURCE_LOCATION")}"
}

variable "managed_image_name" {
  type    = string
  default = "${env("MANAGED_IMAGE_NAME")}"
}

variable "managed_image_version" {
  type    = string
  default = "${env("MANAGED_IMAGE_VERSION")}"
}

variable "managed_image_storage_account_type" {
  type    = string
  default = "${env("MANAGED_IMAGE_STORAGE_ACCOUNT_TYPE")}"
}

variable "private_virtual_network_with_public_ip" {
  type    = bool
  default = "${env("PRIVATE_VIRTUAL_NETWORK_WITH_PUBLIC_IP")}"
}

variable "resource_group" {
  type    = string
  default = "${env("ARM_RESOURCE_GROUP")}"
}

variable "run_validation_diskspace" {
  type    = bool
  default = "${env("RUN_VALIDATION_FLAG")}"
}

variable "subscription_id" {
  type    = string
  default = "${env("ARM_SUBSCRIPTION_ID")}"
}

variable "temp_resource_group_name" {
  type    = string
  default = "${env("TEMP_RESOURCE_GROUP_NAME")}"
}

variable "tenant_id" {
  type    = string
  default = "${env("ARM_TENANT_ID")}"
}

variable "virtual_network_name" {
  type    = string
  default = "${env("VNET_NAME")}"
}

variable "virtual_network_resource_group_name" {
  type    = string
  default = "${env("VNET_RESOURCE_GROUP")}"
}

variable "virtual_network_subnet_name" {
  type    = string
  default = "${env("VNET_SUBNET")}"
}

variable "vm_size" {
  type    = string
  default = "Standard_D4s_v4"
}

variable "azure_tag" {
  type    = map(string)
  default = {}
}

# Define image_gallery_destination object based on current version variable
# only publish to image gallery on main versions.
locals {
  image_gallery_destination = length(regexall("^(?P<major>0|[1-9]\\d*)\\.(?P<minor>0|[1-9]\\d*)\\.(?P<patch>0|[1-9]\\d*)$", var.managed_image_version)) > 0 ? [
  {
    subscription = var.image_gallery_subscription
    resource_group = var.image_gallery_resource_group
    gallery_name = var.image_gallery_name
    image_name = var.managed_image_name
    image_version = var.managed_image_version
    replication_regions = jsondecode(var.image_gallery_regions)
    storage_account_type = var.image_gallery_replication
  }] : []
}

# A build block runs provisioner and post-processors on a source
# Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "azure-arm" "build_managed" {
  allowed_inbound_ip_addresses           = "${var.allowed_inbound_ip_addresses}"
  build_resource_group_name              = "${var.build_resource_group_name}"
  client_cert_path                       = "${var.client_cert_path}"
  client_id                              = "${var.client_id}"
  client_secret                          = "${var.client_secret}"
  image_offer                            = "UbuntuServer"
  image_publisher                        = "Canonical"
  image_sku                              = "18_04-lts-gen2"
  location                               = "${var.location}"
  managed_image_name                     = "${var.managed_image_name}_${var.managed_image_version}"
  managed_image_resource_group_name      = "${var.resource_group}"
  managed_image_storage_account_type     = "${var.managed_image_storage_account_type}"
  os_disk_size_gb                        = "86"
  os_type                                = "Linux"
  private_virtual_network_with_public_ip = "${var.private_virtual_network_with_public_ip}"  
  subscription_id                     = "${var.subscription_id}"
  temp_resource_group_name            = "${var.temp_resource_group_name}"
  tenant_id                           = "${var.tenant_id}"
  virtual_network_name                = "${var.virtual_network_name}"
  virtual_network_resource_group_name = "${var.virtual_network_resource_group_name}"
  virtual_network_subnet_name         = "${var.virtual_network_subnet_name}"
  vm_size                             = "${var.vm_size}"

  dynamic "shared_image_gallery_destination" {
    for_each = local.image_gallery_destination
    content {
      subscription = shared_image_gallery_destination.value.subscription
      resource_group = shared_image_gallery_destination.value.resource_group
      gallery_name = shared_image_gallery_destination.value.gallery_name
      image_name = shared_image_gallery_destination.value.image_name
      image_version = shared_image_gallery_destination.value.image_version
      replication_regions = shared_image_gallery_destination.value.replication_regions
      storage_account_type = shared_image_gallery_destination.value.storage_account_type
    }
  }

  dynamic "azure_tag" {
    for_each = var.azure_tag
    content {
      name = azure_tag.key
      value = azure_tag.value
    }
  }
}

# A build block invokes sources and runs provisioning steps on them. 
# The documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.azure-arm.build_managed"]

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = ["mkdir ${var.image_folder}", "chmod 777 ${var.image_folder}"]
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "${path.root}/scripts/base/apt-mock.sh"
  }

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/base/repos.sh"]
  }

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script           = "${path.root}/scripts/base/apt.sh"
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "${path.root}/scripts/base/limits.sh"
  }

  provisioner "file" {
    destination = "${var.helper_script_folder}"
    source      = "${path.root}/scripts/helpers"
  }

  provisioner "file" {
    destination = "${var.installer_script_folder}"
    source      = "${path.root}/scripts/installers"
  }

  provisioner "file" {
    destination = "${var.image_folder}"
    source      = "${path.root}/post-generation"
  }

  provisioner "file" {
    destination = "${var.image_folder}"
    source      = "${path.root}/scripts/tests"
  }

  provisioner "file" {
    destination = "${var.image_folder}"
    source      = "${path.root}/scripts/SoftwareReport"
  }

  provisioner "file" {
    destination = "${var.image_folder}/SoftwareReport/"
    source      = "${path.root}/../../helpers/software-report-base"
  }

  provisioner "file" {
    destination = "${var.installer_script_folder}/toolset.json"
    source      = "${path.root}/toolsets/toolset-1804.json"
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_VERSION=${var.image_version}", "IMAGEDATA_FILE=${var.imagedata_file}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/preimagedata.sh"]
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_VERSION=${var.image_version}", "IMAGE_OS=${var.image_os}", "HELPER_SCRIPTS=${var.helper_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/configure-environment.sh"]
  }

  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPTS=${var.helper_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/complete-snap-setup.sh", "${path.root}/scripts/installers/powershellcore.sh"]
  }

  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPTS=${var.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} pwsh -f {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/Install-PowerShellModules.ps1", "${path.root}/scripts/installers/Install-AzureModules.ps1"]
  }

  /* lite init*/
  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPTS=${var.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}", "DOCKERHUB_LOGIN=${var.dockerhub_login}", "DOCKERHUB_PASSWORD=${var.dockerhub_password}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/docker-compose.sh", "${path.root}/scripts/installers/docker-moby.sh"]
  }

  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPTS=${var.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}", "DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
                        "${path.root}/scripts/installers/azcopy.sh", 
                        "${path.root}/scripts/installers/azure-cli.sh", 
                        "${path.root}/scripts/installers/azure-devops-cli.sh", 
                        "${path.root}/scripts/installers/basic.sh", 
                        "${path.root}/scripts/installers/bicep.sh", 
                        "${path.root}/scripts/installers/aliyun-cli.sh", 
                        "${path.root}/scripts/installers/apache.sh",    
                        "${path.root}/scripts/installers/clang.sh", 
                        "${path.root}/scripts/installers/swift.sh", 
                        "${path.root}/scripts/installers/cmake.sh", 
                        "${path.root}/scripts/installers/codeql-bundle.sh", 
                        "${path.root}/scripts/installers/containers.sh", 
                        "${path.root}/scripts/installers/dotnetcore-sdk.sh", 
                        "${path.root}/scripts/installers/erlang.sh", 
                        "${path.root}/scripts/installers/firefox.sh", 
                        "${path.root}/scripts/installers/microsoft-edge.sh", 
                        "${path.root}/scripts/installers/gcc.sh", 
                        "${path.root}/scripts/installers/gfortran.sh", 
                        "${path.root}/scripts/installers/git.sh", 
                        "${path.root}/scripts/installers/github-cli.sh", 
                        "${path.root}/scripts/installers/google-chrome.sh", 
                        "${path.root}/scripts/installers/google-cloud-sdk.sh", 
                        "${path.root}/scripts/installers/haskell.sh", 
                        "${path.root}/scripts/installers/heroku.sh", 
                        "${path.root}/scripts/installers/hhvm.sh", 
                        "${path.root}/scripts/installers/java-tools.sh", 
                        "${path.root}/scripts/installers/kubernetes-tools.sh", 
                        "${path.root}/scripts/installers/oc.sh", 
                        "${path.root}/scripts/installers/leiningen.sh", 
                        "${path.root}/scripts/installers/miniconda.sh", 
                        "${path.root}/scripts/installers/mono.sh", 
                        "${path.root}/scripts/installers/kotlin.sh", 
                        "${path.root}/scripts/installers/mysql.sh", 
                        "${path.root}/scripts/installers/mssql-cmd-tools.sh", 
                        "${path.root}/scripts/installers/sqlpackage.sh", 
                        "${path.root}/scripts/installers/nginx.sh", 
                        "${path.root}/scripts/installers/nvm.sh", 
                        "${path.root}/scripts/installers/nodejs.sh", 
                        "${path.root}/scripts/installers/bazel.sh", 
                        "${path.root}/scripts/installers/oras-cli.sh", 
                        "${path.root}/scripts/installers/phantomjs.sh", 
                        "${path.root}/scripts/installers/php.sh", 
                        "${path.root}/scripts/installers/postgresql.sh", 
                        "${path.root}/scripts/installers/pulumi.sh", 
                        "${path.root}/scripts/installers/ruby.sh", 
                        "${path.root}/scripts/installers/r.sh", 
                        "${path.root}/scripts/installers/rust.sh", 
                        "${path.root}/scripts/installers/julia.sh", 
                        "${path.root}/scripts/installers/sbt.sh", 
                        "${path.root}/scripts/installers/selenium.sh", 
                        "${path.root}/scripts/installers/terraform.sh", 
                        "${path.root}/scripts/installers/packer.sh", 
                        "${path.root}/scripts/installers/vcpkg.sh", 
                        "${path.root}/scripts/installers/dpkg-config.sh", 
                        "${path.root}/scripts/installers/mongodb.sh", 
                        "${path.root}/scripts/installers/yq.sh", 
                        "${path.root}/scripts/installers/android.sh", 
                        "${path.root}/scripts/installers/pypy.sh", 
                        "${path.root}/scripts/installers/python.sh", 
                        "${path.root}/scripts/installers/aws.sh", 
                        "${path.root}/scripts/installers/zstd.sh"
                      ]
  }

  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPTS=${var.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} pwsh -f {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/Install-Toolset.ps1", "${path.root}/scripts/installers/Configure-Toolset.ps1"]
  }

  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPTS=${var.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/pipx-packages.sh"]
  }

  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPTS=${var.helper_script_folder}", "DEBIAN_FRONTEND=noninteractive", "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"]
    execute_command  = "/bin/sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/homebrew.sh"]
  }
  /* lite end*/

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "${path.root}/scripts/base/snap.sh"
  }

  provisioner "shell" {
    execute_command   = "/bin/sh -c '{{ .Vars }} {{ .Path }}'"
    expect_disconnect = true
    scripts           = ["${path.root}/scripts/base/reboot.sh"]
  }

  provisioner "shell" {
    execute_command     = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    pause_before        = "1m0s"
    scripts             = ["${path.root}/scripts/installers/cleanup.sh"]
    start_retry_timeout = "10m"
  }

  /* lite init*/
  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "${path.root}/scripts/base/apt-mock-remove.sh"
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_VERSION=${var.image_version}", "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"]
    inline           = ["pwsh -File ${var.image_folder}/SoftwareReport/SoftwareReport.Generator.ps1 -OutputDirectory ${var.image_folder}", "pwsh -File ${var.image_folder}/tests/RunAll-Tests.ps1 -OutputDirectory ${var.image_folder}"]
  }

  provisioner "file" {
    destination = "${path.root}/Ubuntu1804-Readme.md"
    direction   = "download"
    source      = "${var.image_folder}/software-report.md"
  }

  provisioner "file" {
    destination = "${path.root}/software-report.json"
    direction   = "download"
    source      = "${var.image_folder}/software-report.json"
  }

  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPT_FOLDER=${var.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}", "IMAGE_FOLDER=${var.image_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/post-deployment.sh"]
  }
  /* lite end*/

  provisioner "shell" {
    environment_vars = ["RUN_VALIDATION=${var.run_validation_diskspace}"]
    scripts          = ["${path.root}/scripts/installers/validate-disk-space.sh"]
  }

  provisioner "file" {
    destination = "/tmp/"
    source      = "${path.root}/config/ubuntu1804.conf"
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = ["mkdir -p /etc/vsts", "cp /tmp/ubuntu1804.conf /etc/vsts/machine_instance.conf"]
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = ["sleep 30", "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
  }
}