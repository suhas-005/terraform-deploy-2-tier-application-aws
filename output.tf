output "ELB_DNS" {
  value = "${module.load_balancer.ALB_DNS_NAME}"
}