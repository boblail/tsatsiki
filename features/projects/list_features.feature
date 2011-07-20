Feature: Show Project
  
  
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
