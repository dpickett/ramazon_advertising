When /^I try to find the asin "([^\"]*)"$/ do |asin|
  @products = Ramazon::Product.find(:item_id => asin, :response_group => "Medium")
  @product = @products[0]
end

When /^I try to search for the "([^\"]*)" of "([^\"]*)"$/ do |option, value|
  begin
    @products = Ramazon::Product.find(option.to_sym => value)
  rescue Ramazon::Error => e
    @error = e
  end
end

Then /^I should get a list of products$/ do
  @products.should_not be_empty
end

Then /^each product should have the "([^\"]*)" "([^\"]*)"$/ do |attr, value|
  @products.each do |p|
    p.send(attr).should eql(value)
  end
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

