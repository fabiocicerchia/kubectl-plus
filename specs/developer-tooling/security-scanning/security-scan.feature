@domain:developer-tooling @area:security-scanning @from:kubectl-plus/makefile
Feature: Scanning the repository for security issues
  Gives a contributor the same vulnerability, misconfiguration and secret scan CI runs, so they find problems before opening a pull request.

  @id:developer-tooling.security-scanning.001 @rule:devtooling.scan.requires-trivy @inferred @source:Makefile#analyze
  Scenario: The security scan refuses to run without the scanner installed
    Given trivy is not installed on the contributor's machine
    When the contributor runs the security scan
    Then the message "analyze needs trivy: https://trivy.dev/latest/getting-started/installation/" is printed to stderr
    And the command exits with status 69
    And no scan is performed

  @id:developer-tooling.security-scanning.002 @rule:devtooling.scan.high-and-critical-findings @inferred @source:Makefile#analyze
  Scenario: The security scan reports only high and critical vulnerabilities, misconfigurations and secrets
    Given trivy is installed on the contributor's machine
    When the contributor runs the security scan
    Then the whole repository tree is scanned for vulnerabilities, misconfigurations and secrets
    And only findings of severity CRITICAL or HIGH are reported
