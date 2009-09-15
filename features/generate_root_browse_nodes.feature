Feature: As a user of the Ramazon Advertising API
  I want a list of browse nodes
  So that I have starting points for browse node traversal

  Scenario: Retrieving root browse nodes
    Given I want browse nodes to be stored in a temporary file
    And the browse node temporary file doesn't exist
    When I retrieve root nodes
    Then I should get a temporary file for root nodes
    And I should have a "Books" root node
    And I should have a "Grocery" root node
    And I should have a list of root nodes
 
