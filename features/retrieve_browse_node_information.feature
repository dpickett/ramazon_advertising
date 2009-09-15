Feature: As a user of the ramazon advertising api
  I want to get browse node information
  So I can retrieve Amazon product data more effectively

  Scenario: Fetch "Other Video Games" Node
    Given I want browse node information for the node "294940"
    When I retrieve the browse node
    Then the browse node should have a name
    And the browse node should have "children"
    And the browse node should have a "child_hash"
