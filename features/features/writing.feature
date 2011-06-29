Feature: Writing Features


  @some-tag
  Scenario: If I parse and render this file, it should look just like this file
    When I load the feature "features/writing.feature"
    And I render the feature
    Then the result should be identical to "features/writing.feature"
