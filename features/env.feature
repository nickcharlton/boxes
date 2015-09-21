Feature: We can manage the boxes environment

  Scenario: It shows the environment by default
    When I run `boxes env`
    Then the output should contain "Configuration:"
    Then the output should contain "Environment Variables:"
    And the exit status should be 0

  Scenario: It has a show command
    When I run `boxes env show`
    Then the output should contain "Configuration:"
    Then the output should contain "Environment Variables:"
    And the exit status should be 0
