@domain:documentation @area:page-components @from:docs/stylesheets
Feature: Presenting documentation page components
  Gives the docs home page a branded hero, call-to-action buttons and feature cards so readers can see what kubectl-plus offers and where to go next.

  Background:
    Given the site's accent pair is light blue #38bdf8 and blue #3b82f6

  @id:documentation.page-components.001 @rule:documentation.components.hero-gradient-title @inferred @source:docs/stylesheets/extra.css#.md-typeset .hero
  Scenario: The home page hero shows a large centred title in the accent gradient
    Given a page contains a hero block with a title, a tagline and buttons
    When the reader opens that page
    Then the hero is centred
    And the title is shown large with its letters filled by the light-blue-to-blue gradient
    And the tagline is shown in muted text under the title
    And adjacent hero buttons are spaced apart

  @id:documentation.page-components.002 @rule:documentation.components.primary-button-gradient @inferred @source:docs/stylesheets/extra.css#.md-typeset .md-button
  Scenario: Primary buttons are pill-shaped and filled with the accent gradient
    Given a page contains a primary button and a plain button
    When the reader hovers over a button
    Then both buttons are pill-shaped
    And the primary button is filled with the light-blue-to-blue gradient and has white text
    And the hovered button lifts slightly and casts a soft glow

  @id:documentation.page-components.003 @rule:documentation.components.feature-card-hover @inferred @source:docs/stylesheets/extra.css#.md-typeset .grid.cards > ul > li
  Scenario: Feature cards are rounded tiles that lift and gain an accent border on hover
    Given a page contains a grid of feature cards with icons
    When the reader hovers over a card
    Then each card is a rounded, bordered tile with its icon in light blue #38bdf8
    And the hovered card rises slightly, gains a shadow and its border takes on a faint light-blue accent tint
