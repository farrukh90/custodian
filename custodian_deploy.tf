resource "null_resource" "custodian_deploy" {
  triggers = {
    always_run = "${timestamp()}"
  }
 provisioner "local-exec" {
    command = "custodian run --output-dir=. policy.yml  --region=us-east-1" 
  }
}
resource "null_resource" "mailer_deploy" {
  triggers = {
    always_run = "${timestamp()}"
  }
 provisioner "local-exec" {
    command = "c7n-mailer --config mailer.yml --update-lambda " 
  }
}
resource "null_resource" "unused_sec_groups" {
  triggers = {
    always_run = "${timestamp()}"
  }
 provisioner "local-exec" {
    command = "custodian run --output-dir=. unused.yml  --region=us-east-1"
  }
}