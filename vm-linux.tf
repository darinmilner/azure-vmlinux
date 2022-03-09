# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "mylinuxvm" {
  name                = local.vm-name
  computer_name       = local.vm-name # Hostname of the VM
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  size                = "Standard_DS1_v2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.myvmnic.id
  ]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraformazure.pub")
  }
  os_disk {
    name                 = "osdisk${random_string.myrandom.id}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }

  # connection block
  connection {
    type        = "ssh"
    host        = self.public_ip_address
    user        = self.admin_username
    private_key = file("${path.module}/ssh-keys/terraformazure.pem")
  }

  provisioner "file" {
    source      = "apps/file-copy.html"
    destination = "/tmp/file-copy.html"
  }

  provisioner "file" {
    content     = "VM Host name: ${self.computer_name}"
    destination = "/tmp/file.log"
  }

  provisioner "file" {
    source      = "apps/app1"
    destination = "/tmp"
  }

  provisioner "file" {
    source      = "apps/app2/"
    destination = "/tmp"
  }

  custom_data = filebase64("${path.module}/app-scripts/app1-cloud-init.txt")
  tags        = local.common-tags
}
