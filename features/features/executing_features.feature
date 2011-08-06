Feature: Running Cucumber from the Browser
  
  
  @human
  @milestone=0.2.1
  @javascript
  Scenario: I can run Cucumber from the browser and see test results in real time
    Given I am on the Tsatsiki project page
    When I click on "Test Features"
    Then I should see the test results
  
  
  @human
  @milestone=0.2.1
  @javascript
  Scenario: If an error occurs when running Cucumber, I can see that the process has stopped
    Given I am on the Tsatsiki project page
    When I click on "Test Features"
    Then I should see "Loading..."
    And I should not see "Test Features"
    
    When an error occurs
    Then I should see "Test Features"
    And I should not see "Loading..."
    