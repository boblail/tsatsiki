Feature: Features


  @milestone=0.1.0
  Scenario: List Features
    When I am on the Tsatsiki project page
    Then I should see the Tsatsiki features


  @milestone=0.1.0
  Scenario: Features should be grouped by their paths
    When I am on the Tsatsiki project page
    Then the "Show Project" feature should be in the category "/projects"
