Feature: As a user of the Ramazon Advertising wrapper
  I want to get search bins
  So I can efficiently narrow down results

  Scenario: Getting DVD search bins
    Given I am searching with the "search_index" of "DVD"
    And I am searching with the "response_group" of "Medium,SearchBins"
    And I am searching with the "browse_node" of "130"
    When I perform the product search
    Then I should get a list of products
    And the list of products should have more than 1 product
    And the list of products should have "search_bin_sets"
    And each "search_bin_set" in the list of products should have "search_bins"

  Scenario: Getting Genre search bins
    Given I am searching with the "search_index" of "DVD"
    And I am searching with the "response_group" of "Medium,SearchBins"
    And I am searching with the "browse_node" of "405391011"
    When I perform the product search
    Then I should get a list of products
    And the list of products should have "search_bin_sets"
    And each "search_bin_set" in the list of products should have "search_bins"
