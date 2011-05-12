Feature: Show Project

  Scenario: List Features
    When I am on the Tsatsiki project page
    Then I should see the Tsatsiki features

  Scenario: Features should be grouped by their paths
    When I am on the Tsatsiki project page
    Then I the "Show Project" feature should be in the category "/projects"

  @human
  Scenario: Features tagged @human should not be executed
    When I am on the Tsatsiki project page
    And I click "Test Features"
    Then this feature should not be executed
    