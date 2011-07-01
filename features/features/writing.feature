# Comment on a feature
Feature: Writing Features
  When I parse this file
  The different kinds of nodes should be correctly identified
  And preserved when the file is written


  # Comment on a scenario
  @some-tag
  Scenario: If I parse and render this file, it should look just like this file
    Given this feature has a table:
      | questions                                | answers |
      | Does Tsatsiki taste good with spaghetti? | No      |
      | Does Tsatsiki taste good with gyros?     | Yes     |
    When I load the feature "features/writing.feature"
    And I render the feature
    Then the result should be identical to "features/writing.feature"
