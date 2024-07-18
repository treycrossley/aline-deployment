plugin "aws" {
  enabled = true
  version = "0.24.1"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# Configuration options
config {
    call_module_type = "all"   # Replace deprecated 'module' with 'call_module_type'
    force = false
    disabled_by_default = false
}