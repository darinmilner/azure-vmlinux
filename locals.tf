locals {
  rg-name   = "${var.business-unit}-${var.environment}-rg"
  vnet-name = "${var.business-unit}-${var.environment}-vnet"
  snet-name = "${var.business-unit}-${var.environment}-snet"
  pip-name  = "${var.business-unit}-${var.environment}-pip"
  nic-name  = "${var.business-unit}-${var.environment}-nic"
  vm-name   = "${var.business-unit}-${var.environment}-vm"

  service-name = "Terraform-Azure-Demo"
  common-tags = {
    Environment = "${var.environment}"
    Service     = local.service-name
  }
}
