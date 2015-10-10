Feature: We can build boxes

  Scenario: It will error without a name
    When I run `boxes build --template=ubuntu/trusty64 --provider=vmware`
    Then the output should contain "[!] A name is required!"
    And the exit status should be 1

  Scenario: It will error without a provider
    When I run `boxes build --name=trusty64-standard --template=ubuntu/trusty64`
    Then the output should contain "[!] A provider is required!"
    And the exit status should be 1

  Scenario: It will error without a template
    When I run `boxes build --name=trusty64-standard --provider=vmware`
    Then the output should contain "[!] A template is required!"
    And the exit status should be 1
