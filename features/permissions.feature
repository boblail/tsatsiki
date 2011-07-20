Feature: Permissions


  @milestone=0.2.0
  Scenario Outline: I can access the things I have permission to
    Given I am logged in
    And there is a project "Tsatsiki"
    And I have "<privilege>" privileges for <subject>
    When I go to <url>
    Then I should not see the alert "You are not authorized"
    
    Examples:
      | privilege     | subject                   | url                                                       |
      | read          | the project               | the project's page                                        |
      | update        | the project               | the project's settings page                               |
      | read          | the project's features    | the page for one of the project's scenarios               |
      | update        | the project's features    | the edit page for one of the project's scenarios          |
      | manage        | the project's features    | the new scenario page for one of the project's features   |


  @milestone=0.2.0
  Scenario Outline: I can not access the things I don't have permission to
    Given I am logged in
    And there is a project "Tsatsiki"
    And I have "<privilege>" privileges for <subject>
    When I go to <url>
    Then I should see the alert "You are not authorized"
    
    Examples:
      | privilege     | subject                   | url                                                       |
      | read          | the project               | the project's settings page                               |
      | read          | the project's features    | the edit page for one of the project's scenarios          |
      | read          | the project's features    | the new scenario page for one of the project's features   |
      | update        | the project's features    | the new scenario page for one of the project's features   |

