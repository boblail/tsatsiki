Feature: Creating Features


  # !todo: after running this scenario, revert this file (without specifying in the steps)
  @milestone=0.1.0
  Scenario: I can add a new Scenario to a Feature file
    Given I am logged in as an admin
    And this feature is "features/managing_features/creating_features.feature"
    And this feature exists
    And I am on the new scenario page for this feature
    When I press "Save Changes"
    Then this feature should contain a scenario "New Feature"
    But revert this feature


  # !todo: after running this scenario, remove the new file (without specifying in the steps)
  @milestone=0.1.0
  Scenario: I can add a new Scenario to a Feature that doesn't yet have a file
    Given I am logged in as an admin
    And this feature is "features/managing_features.feature"
    And this feature does not exist
    And I am on the new scenario page for this feature
    When I press "Save Changes"
    Then this feature should exist
    Then this feature should contain a scenario "New Feature"
    But revert this feature
