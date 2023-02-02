resource "aws_instance" "Public1" {
    ami = "ami-0aa7d40eeae50c9a9"
    instance_type = var.instance_type
    subnet_id = var.pub1_sub
    security_groups = [ "${var.sg-instance}" ]
    key_name = "myterrakey"
    tags = {
        Name = "Public1"
    }
}
resource "aws_instance" "Private1" {
    ami = "ami-0aa7d40eeae50c9a9"
    instance_type = var.instance_type
    subnet_id = var.prv1_sub
    security_groups = [ "${var.sg-instance}" ]
    key_name = "myterrakey"
    tags = {
        Name = "Private1"
    }
}