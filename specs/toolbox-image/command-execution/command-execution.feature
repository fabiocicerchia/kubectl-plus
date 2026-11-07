@domain:toolbox-image @area:command-execution @from:kubectl-plus/dockerfile
Feature: Running automation scripts in the image
  Lets a Job or CI step pass a plain script string as its arguments and have bash run it, with the result deciding whether the step passes.

  @id:toolbox-image.command-execution.001 @rule:toolbox.exec.default-prints-kubectl-version @inferred @source:Dockerfile#CMD
  Scenario: Without a command the container prints the kubectl client version
    Given no command is passed to the container
    When the operator starts the container
    Then the kubectl client version is printed
    And the container exits with status 0

  @id:toolbox-image.command-execution.002 @rule:toolbox.exec.script-string-runs-in-bash @inferred @source:Dockerfile#ENTRYPOINT
  Scenario: A script string passed as the argument runs as a bash script
    Given a Job passes the argument "IMAGE=$(kubectl get deploy my-app -o json | jq -r '.metadata.name'); echo $IMAGE"
    When the Job's container starts
    Then the whole string is run by bash, including the pipes and variable expansion
    And the output of the script appears in the container log

  @id:toolbox-image.command-execution.003 @rule:toolbox.exec.script-failure-fails-container @inferred @source:Dockerfile#ENTRYPOINT @questionable
  Scenario: A failing script makes the container fail
    Given a Job passes a script whose last command is "kubectl get deploy missing-app" and the deployment does not exist
    When the Job's container runs the script
    Then the container exits with a non-zero status
    And the Job reports the pod as failed
