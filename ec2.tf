# creating ec2 instance

# resource "aws_instance" "terraformserv"  {
  



#   ami                    = "ami-0005e0cfe09cc9050"
#   instance_type          = "t2.micro"
#   key_name               = "data.aws_key_pair.Harshakeypair.key_name"
  
 
  
#   subnet_id              = "subnet-0bb5903d5ca1836f6"

#   tags = {
#     Name  = "terraformser"
    
#   }
# }

data "aws_key_pair" "Harshakeypair" {
  key_name           = "HarshaIDkeypair"
  include_public_key = true
}

output "fingerprint" {
  value = data.aws_key_pair.Harshakeypair.fingerprint
}

output "name" {
  value = data.aws_key_pair.Harshakeypair.key_name
}

output "id" {
  value = data.aws_key_pair.Harshakeypair.id
}