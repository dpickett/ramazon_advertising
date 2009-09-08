@errors
Feature: Friendly errors
  As a user of ramazon_advertising
  I want to get friendly error messages
  So that I know I did something wrong

  Background: 
    Given I have a valid access key
    And I have a valid secret key

  Scenario: I don't specify a keyword for search
    When I perform the product search
    Then I should get an error
    And the error should have a "code" of "AWS.MinimumParameterRequirement"
    And the error should have a "message"
