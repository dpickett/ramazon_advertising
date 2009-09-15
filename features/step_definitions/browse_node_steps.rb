Given /^I want browse nodes to be stored in a temporary file$/ do
  @browse_root_filename = File.join(File.dirname(__FILE__), '..', 'support', 'root_nodes.yml')
end

Given /^the browse node temporary file doesn't exist$/ do
  FileUtils.rm_f @browse_root_filename
end

Given /^I want browse node information for the node "([^\"]*)"$/ do |node_id|
  @node_id = node_id
end

When /^I retrieve root nodes$/ do
  if @browse_root_filename
    Ramazon::BrowseNode.generate_root_nodes @browse_root_filename
  else
    Ramazon::BrowseNode.generate_root_nodes
  end
end

When /^I retrieve the browse node$/ do
  @node = Ramazon::BrowseNode.find(@node_id)
end

Then /^the browse node should have a name$/ do
  @node.name.should_not be_nil
end

Then /^the browse node should have (a\s)?"(.*)"$/ do |a, attr|
  @node.send(attr).should_not be_nil
  if @node.send(attr).respond_to?(:empty?)
    @node.send(attr).should_not be_empty
  end
end

Then /^I should get a temporary file for root nodes$/ do
  FileTest.exists?(@browse_root_filename).should be_true
end

Then /^I should have a "([^\"]*)" root node$/ do |name|
  get_root_nodes[name].should_not be_nil
end

Then /^I should have a list of root nodes$/ do
  get_root_nodes.should_not be_empty
end

def get_root_nodes
  if @browse_root_filename
    nodes = Ramazon::BrowseNode.root_nodes(@browse_root_filename)
  else
    nodes = Ramazon::BrowseNode.root_nodes
  end

end
