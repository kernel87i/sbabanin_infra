provider "google" {
  project     = "${var.project}"
  version     = "2.0.0"
  region      = "${var.region}"
  zone        = "${var.zone}"
  credentials = "${file("/tmp/terraform1/infra-56cf0aa341c8.json")}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
