@domain:toolbox-image @area:runtime-security @from:kubectl-plus/dockerfile
Feature: Running the toolbox image securely
  Lets operators run cluster automation without root inside the container and trust that the cluster client they get is the official one.

  @id:toolbox-image.runtime-security.001 @rule:toolbox.security.runs-as-non-root @inferred @source:Dockerfile#USER
  Scenario: The container runs as the non-root automation user
    Given no user override is set for the container
    When the operator runs "id" in the container
    Then the user id is 10001
    And the user name is automation
    And the user is not root

  @id:toolbox-image.runtime-security.002 @rule:toolbox.security.kubectl-checksum-verified @inferred @source:Dockerfile#fetch
  Scenario: An image is never published with a kubectl that fails its official checksum
    Given the kubectl binary downloaded for the release does not match the checksum published on dl.k8s.io
    When the maintainer builds the image
    Then the build stops with a checksum verification failure
    And no image containing that kubectl is produced

  @id:toolbox-image.runtime-security.003 @rule:toolbox.security.yq-not-checksum-verified @inferred @source:Dockerfile#fetch @questionable
  Scenario: The bundled yq is not checksum-verified
    Given the yq release asset served for the pinned version has been altered
    When the maintainer builds the image
    Then the build completes
    And the altered yq binary is in the image
