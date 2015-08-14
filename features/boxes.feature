Feature: We can return the boxes help

  Scenario: A successful response
    When I run `boxes --help`
    Then the output should contain "$ boxes"
    Then the output should contain "Usage:"
    Then the output should contain "Options:"
    And the exit status should be 0
