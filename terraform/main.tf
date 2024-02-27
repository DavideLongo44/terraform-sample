
module "web-server" {
  source      = "./web-server-module"
  region      = "eu-central-1"
  ami         = "ami-024f768332f080c5e"
  environment = "test"
  key_name    = "banana2"
}
module "banana" {
  source      = "./web-server-module"
  region      = "eu-central-1"
  ami         = "ami-024f768332f080c5e"
  environment = "banana"
  key_name    = "banana2"
}
module "mela" {
  source      = "./web-server-module"
  region      = "eu-central-1"
  ami         = "ami-024f768332f080c5e"
  environment = "bananadev"
  key_name    = "banana2"
}