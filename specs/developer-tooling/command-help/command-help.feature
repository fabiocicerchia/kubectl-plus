@domain:developer-tooling @area:command-help @from:kubectl-plus/makefile
Feature: Discovering the available commands
  Lets a contributor see every repository command and what it does without reading the build file.

  @id:developer-tooling.command-help.001 @rule:devtooling.help.default-lists-commands @inferred @source:Makefile#help
  Scenario: Running make with no command lists every documented command with its description
    Given the contributor is in the repository root
    When the contributor runs make with no command
    Then one line per documented command is printed: help, setup, install, build, test, lint, run, format, analyze, push, release
    And each line shows the command name followed by its one-line description, e.g. "build      Build the image locally"
    And nothing is built or run
