@domain:distribution @area:local-usage @from:kubectl-plus/makefile
Feature: Running the toolbox from a workstation
  Lets an operator pull or run the kubectl-plus toolbox at a chosen kubectl version on their own machine, against their own kubeconfig, before wiring it into a Job or CI step.

  Background:
    Given the toolbox image is published as ghcr.io/fabiocicerchia/kubectl-plus

  @id:distribution.local-usage.001 @rule:distribution.local-run.runs-given-command @inferred @source:Makefile#run
  Scenario Outline: Running the toolbox executes the operator's command, defaulting to the kubectl client version
    Given the operator has not overridden the toolbox version
    When the operator runs the toolbox with the command <command>
    Then the toolbox image ghcr.io/fabiocicerchia/kubectl-plus:1.33.2 is built locally first
    And the container executes <executed>
    And the container is removed when the command finishes

    Examples:
      | command             | executed                 |
      | (none given)        | kubectl version --client |
      | kubectl get pods -A | kubectl get pods -A      |

  @id:distribution.local-usage.002 @rule:distribution.local-run.kubeconfig-read-only @inferred @source:Makefile#run @questionable
  Scenario: The operator's kubeconfig is mounted read-only, at a path the toolbox user never reads
    Given the operator has cluster credentials in their kubeconfig directory ~/.kube
    When the operator runs the toolbox with the command kubectl get pods -A
    Then the operator's ~/.kube directory is mounted into the container read-only at /home/nonroot/.kube
    And the container runs as the automation user (uid 10001) whose home is /home/automation
    And kubectl in the container finds no kubeconfig and cannot reach the operator's cluster

  @id:distribution.local-usage.003 @rule:distribution.local-install.pulls-chosen-version @inferred @source:Makefile#install
  Scenario Outline: Installing pulls the published toolbox at the chosen kubectl version
    Given the operator chooses toolbox version <version>
    When the operator installs the toolbox
    Then the image ghcr.io/fabiocicerchia/kubectl-plus:<tag> is pulled onto the operator's machine

    Examples:
      | version   | tag    |
      | (default) | 1.33.2 |
      | 1.32.0    | 1.32.0 |
