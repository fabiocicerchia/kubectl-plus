@domain:distribution @area:one-line-install @from:kubectl-plus/install
Feature: Installing kubectl-plus with one command
  Lets an operator get the latest kubectl-plus image onto a Docker host with a single curl-pipe-bash command and see how to run it.

  Background:
    Given Docker is installed on the operator's machine

  @id:distribution.one-line-install.001 @rule:distribution.install.pulls-latest-from-ghcr @inferred @source:install.sh#IMAGE
  Scenario: The installer pulls the latest kubectl-plus image from GHCR
    Given the image ghcr.io/fabiocicerchia/kubectl-plus:latest is published
    When the operator runs the one-line installer
    Then the operator sees "Pulling kubectl-plus from GHCR..."
    And the image ghcr.io/fabiocicerchia/kubectl-plus:latest is present locally
    And the operator sees "kubectl-plus ready. Example usage:"

  @id:distribution.one-line-install.002 @rule:distribution.install.stops-on-pull-failure @inferred @source:install.sh#IMAGE
  Scenario: A failed pull stops the installer before it claims readiness
    Given the registry cannot be reached or the image cannot be pulled
    When the operator runs the one-line installer
    Then the installer exits with a non-zero status
    And the operator sees Docker's pull error
    And the operator does not see "kubectl-plus ready"

  @id:distribution.one-line-install.003 @rule:distribution.install.prints-example-usage @inferred @source:install.sh#IMAGE @questionable
  Scenario: The installer prints an example docker run command once the pull succeeds
    Given the image pull succeeds
    When the operator runs the one-line installer
    Then the operator sees the example "docker run --rm -v ~/.kube:/home/nonroot/.kube:ro ghcr.io/fabiocicerchia/kubectl-plus:latest get pods -A"
