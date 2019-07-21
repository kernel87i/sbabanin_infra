provider "google" {
  project = "infra-244920"
  version = "2.0.0"
  region = "europe-west-1"
  zone = "europe-west1-b"
  credentials = "${file("/tmp/terraform/infra-56cf0aa341c8.json")}"
}
resource "google_compute_instance" "app" {
  name = "reddit-app"
  machine_type = "g1-small"
  zone = "us-central1-a"

metadata {
  ssh-keys = "appuser:${file("~/.ssh/appuser.pub")}"
}

boot_disk {
  initialize_params {
    image = "reddit-base"
  }
 }

tags = ["reddit-app"]
  network_interface {
  network = "default"
  access_config {}
}

connection {
  type = "ssh"
  user = "appuser"
  agent = false
  private_key = "${file("~/.ssh/appuser")}"
}

provisioner "file" {
  source = "/tmp/terraform/files/puma.service"
  destination = "/tmp/puma.service"
}

provisioner "remote-exec" {
   script = "/tmp/terraform/files/deploy.sh"
}
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  network = "default"
 allow {
  protocol = "tcp"
  ports = ["9292"]
}

 source_ranges = ["0.0.0.0/0"]
 target_tags = ["reddit-app"]
}

