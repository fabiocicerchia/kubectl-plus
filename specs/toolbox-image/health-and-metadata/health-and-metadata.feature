@domain:toolbox-image @area:health-and-metadata @from:kubectl-plus/dockerfile
Feature: Image health and published metadata
  Lets operators and registries see whether the container works, what the image is, and which licenses the image's contents carry.

  @id:toolbox-image.health-and-metadata.001 @rule:toolbox.health.healthy-when-kubectl-runs @inferred @source:Dockerfile#HEALTHCHECK
  Scenario: The container reports healthy while kubectl can run
    Given a container from the image is running under a runtime that honours image health checks
    When the runtime runs the image's health check
    Then the container is healthy if "kubectl version --client" succeeds
    And the container is unhealthy if that command fails

  @id:toolbox-image.health-and-metadata.002 @rule:toolbox.metadata.oci-labels @inferred @source:Dockerfile#LABEL @questionable
  Scenario Outline: The image carries OCI labels identifying it
    Given the image was built with default settings
    When the operator inspects the image label "<label>"
    Then the label value is "<value>"

    Examples:
      | label                                | value                                                              |
      | org.opencontainers.image.title       | kubectl-plus                                                       |
      | org.opencontainers.image.description | kubectl + jq + yq + curl + envsubst for in-cluster automation jobs |
      | org.opencontainers.image.version     | 1.33.2                                                             |
      | org.opencontainers.image.licenses    | Apache-2.0 AND GPL-3.0-or-later AND MIT                            |
      | org.opencontainers.image.source      | https://github.com/fabiocicerchia/kubectl-plus                     |

  @id:toolbox-image.health-and-metadata.003 @rule:toolbox.metadata.notice-bundled @inferred @source:Dockerfile#COPY NOTICE
  Scenario: The image ships the third-party license notice
    When the operator reads /NOTICE in the container
    Then it lists kubectl and yq with their licenses
    And it lists bash, gettext, jq and curl with their licenses
    And it states where the GPL corresponding source for bash and gettext is published
