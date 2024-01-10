module "vpc" {
    source = "../MODULES/VPC"
    vpc_cidr = var.vpc_cidr     
    my_count = var.my_count
    private_count = var.private_count
    priv_assoc_count = var.priv_assoc_count
}

module "asg" {
    source = "../MODULES/ASG"
    image_id = var.image_id                    
    instance_type = var.instance_type           
    key_name = var.key_name                  
    availability_zones = module.vpc.availability_zone
    max_size = 4
    min_size = 1
    desired_capacity = 2
    vpc_id = module.vpc.vpc_id
    subnet_id = element(module.vpc.public_subnets_id, 0)
    zone_identifier = module.vpc.public_subnets_id
    ssh_ingress_port = var.ssh_port 
    http_ingress_port = var.http_port
}

module "database" {
    source = "../MODULES/DATABASE"
    subnet_group = module.vpc.database_subnets_id
    subnet_group_name = var.subnet_group_name
    identifier = var.identifier
    allocated_storage = var.allocated_storage
    engine = var.engine
    engine_version = var.engine_version
    instance_class =  var.instance_class
    db_name =  var.db_name
    replica_identifier =  var.replica_identifier
    replica_instance_class = var.replica_instance_class 
    username = var.username 
    password = var.password
}