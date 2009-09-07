When /^I try to find the asin "([^\"]*)"$/ do |asin|
  @products = Ramazon::Product.find(:item_id => asin, :response_group => "Medium")
  @product = @products[0]
end

Then /^I should get a product$/ do
  @product.should_not be_nil
end

Then /^the product should have the "([^\"]*)" "([^\"]*)"$/ do |attr, value|
  @product.send(attr).should eql(value)
end

Then /^the product should have a "([^\"]*)"$/ do |attr|
  @product.send(attr).should_not be_nil
end

