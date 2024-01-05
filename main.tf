terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"  # Replace with the desired version or use a version constraint
    }
  }
}
provider "aws" { 
	region = "eu-north-1" 
	access_key = "AKIAQA5Z4FAXKY4TSL7W" 
	secret_key = "sQaGBFFDPJ+Bg4iJrfssBsO6um8BcMjvyjavMQvB" 
}
