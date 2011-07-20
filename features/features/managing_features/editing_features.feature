Feature: Editing Features


  # !todo: after running this scenario, revert this file (without specifying in the steps)
  @milestone=0.1.0
  Scenario: I can edit a Scenario
    Given I am logged in as an admin
    And this feature is "features/managing_features/editing_features.feature"
    And this feature exists
    And I am on the edit page for the first scenario in this feature
    And I fill in "Name" with "I did edit a Scenario"
    When I press "Save Changes"
    Then this feature should contain a scenario "I did edit a Scenario"
    But revert this feature
