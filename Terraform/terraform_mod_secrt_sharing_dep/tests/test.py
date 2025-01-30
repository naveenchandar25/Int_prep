import subprocess

def run_terraform_command(command):
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    stdout, stderr = process.communicate()
    return process.returncode, stdout.decode('utf-8'), stderr.decode('utf-8')

def test_terraform_init():
    returncode, stdout, stderr = run_terraform_command('terraform init')
    if returncode == 0:
        print("Terraform init succeeded")
    else:
        print("Terraform init failed")
        print(stderr)

def test_terraform_plan():
    returncode, stdout, stderr = run_terraform_command('terraform plan -var-file="./examples/example_secret.tfvars.tfvars"')
    if returncode == 0:
        print("Terraform plan succeeded")
    else:
        print("Terraform plan failed")
        print(stderr)

def test_terraform_apply():
    returncode, stdout, stderr = run_terraform_command('terraform apply -auto-approve -var-file="./examples/example_secret.tfvars.tfvars"')
    if returncode == 0:
        print("Terraform apply succeeded")
    else:
        print("Terraform apply failed")
        print(stderr)

if __name__ == "__main__":
    test_terraform_init()
    test_terraform_plan()
    test_terraform_apply()