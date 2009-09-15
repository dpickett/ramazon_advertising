Feature: Search for products
  As a user of the Ramazon_advertising api
  I want to perform a search
  In order to find products my customers will want to purchase

  Background:
    Given I have a valid access key
    And I have a valid secret key

  Scenario: Finding dvds
    Given I am searching with the "search_index" of "DVD"
    And I am searching with the "browse_node" of "130"
    When I perform the product search
    Then I should get a list of products
    And the list of products should have more than 1 product
    And each product should have the "product_group" "DVD"

  Scenario: Finding video games
    Given I am searching with the "search_index" of "VideoGames"
    And I am searching with the "response_group" of "Medium,BrowseNodes"
    And I am searching with the "browse_node" of "294940"
    When I perform the product search
    Then I should get a list of products
    And the list of products should have more than 1 product

  Scenario: Finding multiple browse nodes
    Given I am searching with the "search_index" of "VideoGames"
    And I am searching with the "response_group" of "Medium"
    And I am searching with the "browse_node" of "11075221"
    When I perform the product search
    Then I should get a list of products
    And the list of products should have more than 1 product
    And each product should have the "product_group" "Video Games"

  Scenario: Finding All Offers optimization
    Given I am searching with the "search_index" of "VideoGames"
    And I am searching with the "response_group" of "Medium,OfferListings"
    And I am searching with the "merchant_id" of "All"
    And I am searching with the "condition" of "All"
    And I am searching with the "offer_page" of "1"
    And I am searching with the "browse_node" of "11075221"
    When I perform the product search
    Then I should get a list of products
    And each product should have "offer_pages"
    And each product should have "has_first_page_of_full_offers"


