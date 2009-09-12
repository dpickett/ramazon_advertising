When /^I try to find the asin "([^\"]*)"$/ do |asin|
  @products = Ramazon::Product.find(:item_id => asin, :response_group => ["Medium", "BrowseNodes", "Offers"])
  @product = @products[0]
end

Given /^I am searching with the "([^\"]*)" of "([^\"]*)"$/ do |attr, value|
  @search_options ||= {}
  @search_options[attr.to_sym] = value
end

When /^I perform the product search$/ do
  begin
    @search_options ||= {}
    @products = Ramazon::Product.find(@search_options)
  rescue Ramazon::Error => e
    @error = e
  end
end

Then /^I should get a list of products$/ do
  raise @error if @error
  @products.should_not be_empty
end

Then /^the list of products should have more than (\d+) product$/ do |count|
  @products.should have_at_least(count.to_i + 1).items
end


Then /^each product should have the "([^\"]*)" "([^\"]*)"$/ do |attr, value|
  @products.each do |p|
    p.send(attr).should eql(value)
  end
end

Then /^I should get a product$/ do
  raise @error if @error
  @product = @products[0] unless @product
  @product.should_not be_nil
end

Then /^the product should have (the\s)?"([^\"]*)" "([^\"]*)"$/ do |the, attr, value|
  @product.send(attr).should eql(value)
end

Then /^the product should have (a\s)?"([^\"]*)"$/ do |a, attr|
  @product.send(attr).should_not be_nil
end

Then /^each of the product's "([^\"]*)" should have a "([^\"]*)"$/ do |collection_name, attr|
  @product.send(collection_name).should_not be_empty
  @product.send(collection_name).each do |i|
    i.send(attr).should_not be_nil
  end
end

Then /^each of the product's "([^\"]*)" should have a "([^\"]*)" of "([^\"]*)"$/ do |collection_name, attr, value|
  @product.send(collection_name).should_not be_empty
  @product.send(collection_name).each do |i|
    i.send(attr).should_not be_nil
  end
end


Then /^the product should have a category tree for "([^\"]*)"$/ do |category_name|
  @product.category_tree[category_name].should_not be_nil
end

