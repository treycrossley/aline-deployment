plugin "aws" {
enabled = true
version = "0.24.1"
source = "github.com/terraform-linters/tflint-ruleset-aws"
}

config {
    call_module_type = "all" 
    force = false
    disabled_by_default = false
}