Feature: Manage projects
  
  
  @milestone=0.1.0
  Scenario: I can create a new project
    Given I am logged in
    And I am on the new project page
    When I fill in "Name" with "name 1"
    And I fill in "Path" with "path 1"
    And I press "Create"
    Then I should see "name 1"
