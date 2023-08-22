variable "instance_ingress_rules" {
    description = "Ingress rules to apply to the instance"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
}
variable "db_ingress_rules" {
    description = "Ingress rules to apply to the instance"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
}
variable "lb_ingress_rules" {
    description = "Ingress rules to apply to the instance"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
}