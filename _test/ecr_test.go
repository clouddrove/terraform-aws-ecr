// Managed By : CloudDrove
// Description : This Terratest is used to test the Terraform ECR module.
// Copyright @ CloudDrove. All Right Reserved.
package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func Test(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// Source path of Terraform directory.
		TerraformDir: "../_example",
	}

	// This will run 'terraform init' and 'terraform application' and will fail the test if any errors occur
	terraform.InitAndApply(t, terraformOptions)

	// To clean up any resources that have been created, run 'terraform destroy' towards the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// To get the value of an output variable, run 'terraform output'
	Arn := terraform.Output(t, terraformOptions, "arn")
	Tags := terraform.OutputMap(t, terraformOptions, "tags")

	// Check that we get back the outputs that we expect
	assert.Equal(t, "test-ecr-clouddrove", Tags["Name"])
	assert.Contains(t, Arn, "arn:aws:ecr")
}