namespace :ramazon do 
  desc "Generate the yml file used for looking up root browse nodes"
  task :generate_node_yml do
    puts "Generating root nodes"
    Ramazon::BrowseNode.generate_root_nodes
    puts "Done"
  end
end

