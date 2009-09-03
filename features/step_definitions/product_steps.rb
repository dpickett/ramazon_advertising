When /^I try to find the asin "([^\"]*)"$/ do |asin|
  @product = Ramazon::Product.find(:item_id => asin)
end

Then /^I should get a product$/ do
  @product.should_not be_nil
end

Then /^the product should have the "([^\"]*)" "([^\"]*)"$/ do |attr, value|
  pending
end

Then /^the product should have a "([^\"]*)"$/ do |attr|
  pending
end

