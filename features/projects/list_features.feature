Feature: Show Project
  
  
  @milestone=0.1.0
  Scenario: List Features
    When I am on the Tsatsiki project page
    Then I should see the Tsatsiki features
  
  
  @milestone=0.1.0
  Scenario: Features should be grouped by their paths
    When I am on the Tsatsiki project page
    Then the "Show Project" feature should be in the category "/projects"
  
  
  @wip
  @milestone=0.1.0
  Scenario: Features tagged @human should not be executed
    When I am on the Tsatsiki project page
    And I click "Test Features"
    Then this feature should not be executed
  
  
  @human
  @milestone=0.1.0
  Scenario: This feature must be tested by a human
    When I am using Tsatsiki
    Then my life is all unicorns and rainbows :)
