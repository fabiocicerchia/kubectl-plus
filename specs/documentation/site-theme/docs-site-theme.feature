@domain:documentation @area:site-theme @from:docs/stylesheets
Feature: Branding the documentation site
  Gives readers of the kubectl-plus splash page and rendered docs one consistent, legible look that loads nothing from third-party servers.

  Background:
    Given the kubectl-plus documentation is published with the splash page at the site root and the rendered docs under /docs/

  @id:documentation.site-theme.001 @rule:documentation.theme.shared-accent-palette @inferred @source:docs/stylesheets/extra.css#:root
  Scenario: The splash page and the rendered docs share one accent palette
    Given the site's accent pair is light blue #38bdf8 and blue #3b82f6
    When a reader opens the splash page and then the rendered docs
    Then the splash page title and buttons use the same light-blue-to-blue gradient as the docs hero and primary buttons
    And the docs primary colour and links in the light scheme use the blue #3b82f6
    And the docs header takes the page background colour, not the blue
    And changing the accent pair in the one theme stylesheet changes both the splash page and the docs

  @id:documentation.site-theme.002 @rule:documentation.theme.no-network-loaded-assets @inferred @source:docs/stylesheets/extra.css#:root
  Scenario: The docs render with system fonts and load no web fonts
    Given a reader whose browser cannot reach any font CDN
    When the reader opens any documentation page
    Then body text is set in the operating system's sans-serif font (-apple-system, Segoe UI, Roboto, Helvetica, Arial)
    And code is set in the operating system's monospace font (ui-monospace, SF Mono, Menlo, Consolas, Liberation Mono)
    And the page requests no font or stylesheet from a third-party host

  @id:documentation.site-theme.003 @rule:documentation.theme.legible-links-per-scheme @inferred @source:docs/stylesheets/extra.css#[data-md-color-scheme="slate"]
  Scenario Outline: Links use the accent colour that stays readable in the reader's colour scheme
    Given the reader's colour scheme is <scheme>
    When the reader views a documentation page
    Then the page background is <background>
    And links are shown in <link_colour>

    Examples:
      | scheme       | background                                   | link_colour        |
      | light        | Material's default white                     | blue #3b82f6       |
      | dark (slate) | near-black #0b0f1a, header and tabs included | light blue #38bdf8 |

  @id:documentation.site-theme.004 @rule:documentation.theme.no-placeholder-logo @inferred @source:docs/stylesheets/extra.css#.md-header__button.md-logo
  Scenario: The docs header shows no stand-in logo while the project has none
    Given the project has no logo configured for the docs
    When the reader views a documentation page
    Then no logo icon is shown in the header
    And no logo icon is shown in the navigation drawer title
