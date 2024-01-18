#!/bin/bash

set -e

# Define variables
TERRAFORM_CONFIG_DIR="$(pwd)/infra"
CHECKOV_OUTPUT_DIR="$(pwd)/checkov/results"

# Create the output directory if it doesn't exist
mkdir -p "${CHECKOV_OUTPUT_DIR}"

# Navigate to the Terraform configuration directory
cd "${TERRAFORM_CONFIG_DIR}" || exit

# Run checkov against Terraform configurations
checkov -d . -o cli -o json --output-file-path console,"${CHECKOV_OUTPUT_DIR}/checkov_results.json" --soft-fail

# Check the exit status of checkov
CHECKOV_EXIT_CODE=$?

# Print checkov results
cat "${CHECKOV_OUTPUT_DIR}/checkov_results.json"

# Exit with the appropriate status code
exit ${CHECKOV_EXIT_CODE}
