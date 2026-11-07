@domain:toolbox-image @area:bundled-tools @from:kubectl-plus/dockerfile
Feature: Using the bundled automation tools
  Gives in-cluster Jobs, hooks and CI steps kubectl, jq, yq, curl, envsubst and bash in one image so teams stop assembling their own.

  Background:
    Given the operator runs a container from the kubectl-plus image

  @id:toolbox-image.bundled-tools.001 @rule:toolbox.tools.pinned-versions @inferred @source:Dockerfile#ARG KUBECTL_VERSION
  Scenario Outline: Each bundled tool reports its pinned version
    Given the image was built with default settings
    When the operator asks "<tool>" for its version
    Then the reported version is <version>

    Examples:
      | tool    | version |
      | kubectl | 1.33.2  |
      | yq      | 4.45.4  |
      | jq      | 1.8.2   |
      | curl    | 8.23.0  |
      | bash    | 5.3.9   |
