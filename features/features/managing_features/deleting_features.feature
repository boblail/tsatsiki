Feature: Deleting Features
  
  
  @ignore
  Scenario: This scenario will be deleted
  
  
  # !todo: after running this scenario, revert this file (without specifying in the steps)
  @milestone=0.1.0
  Scenario: I can delete a Scenario
    Given I am logged in as an admin
    And this feature is "features/managing_features/deleting_features.feature"
    And this feature exists
    And I am on the edit page for the first scenario in this feature
    When I follow "Destroy"
    Then this feature should not contain a scenario "This scenario will be deleted"
    But revert this feature
