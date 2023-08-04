################################################################################
# Launch template only
################################################################################


module "launch_template" {
  source  = "terraform-aws-modules/autoscaling/aws"


  # Launch template
  launch_template_name        = var.lt_name
  launch_template_description = var.lt_description
  name              = "test"
  create            = "false"
  image_id          = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_groups   = var.security_groups


  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.root_volume_size
        volume_type           = var.root_volume_type
      }
    },
  ]

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = var.security_groups
      subnet_id             = "subnet-0e4c8f1112e78c6a2"
    }
  ]
  tags = {
    Environment = var.env
    Project     = "test"
  }
}



################################################################################
# EC2 Instance
################################################################################

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"
  instance_type          = var.instance_type
  key_name               = "temp"
  monitoring             = true
  vpc_security_group_ids = var.security_groups
  subnet_id              = var.subnet_id
  ami_ssm_parameter      = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
  launch_template        = {

    id = module.launch_template.launch_template_id
    #name = module.launch_template.launch_template_name
    version = module.launch_template.launch_template_latest_version
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}