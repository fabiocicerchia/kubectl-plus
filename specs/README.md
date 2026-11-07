# Specifications of kubectl-plus

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Developer tooling
Build, test and quality gates used by contributors to work on the image.

- **Command discovery**: [Discovering the available commands](developer-tooling/command-help/command-help.feature) (1)
- **Security scanning**: [Scanning the repository for security issues](developer-tooling/security-scanning/security-scan.feature) (2)

## Distribution and installation
How users obtain the image and how new versions are published.

- **Local pull and run**: [Running the toolbox from a workstation](distribution/local-usage/local-run.feature) (3)
- **One-line installer**: [Installing kubectl-plus with one command](distribution/one-line-install/one-line-install.feature) (3)

## Documentation site
The published docs and splash page that explain the product.

- **Page components**: [Presenting documentation page components](documentation/page-components/docs-page-components.feature) (3)
- **Site theme and branding**: [Branding the documentation site](documentation/site-theme/docs-site-theme.feature) (4)

## Automation toolbox image
The container image itself: which CLI tools it ships and how it behaves when run.

- **Bundled tools**: [Using the bundled automation tools](toolbox-image/bundled-tools/bundled-tools.feature) (1)
- **Command execution**: [Running automation scripts in the image](toolbox-image/command-execution/command-execution.feature) (3)
- **Health check and image metadata**: [Image health and published metadata](toolbox-image/health-and-metadata/health-and-metadata.feature) (3)
- **Runtime security**: [Running the toolbox image securely](toolbox-image/runtime-security/runtime-security.feature) (3)
