module Ramazon
  class BrowseNode
    include HTTParty
    include HappyMapper

    tag "BrowseNode"

    element :name, String, :tag => "Name"
    element :node_id, String, :tag => "BrowseNodeId"
    element :children, Ramazon::BrowseNode, :tag => "Children/BrowseNode"
    element :is_category_root, Boolean, :tag => "IsCategoryRoot"

    attr_accessor :child
    
    DEFAULT_ROOT_FILE = File.join(File.dirname(__FILE__), '..', 'root_nodes.yml')

    def self.generate_root_nodes(file_name = DEFAULT_ROOT_FILE)
      if Ramazon::Configuration.locale == :us
        doc = Nokogiri::HTML(get('http://www.amazon.com').body)
        root_nodes = {}
        doc.search(".navSaMenu .navSaChildItem a").each do |element|
          if element["href"] =~ /node=(\d+)\&/
            root_nodes[element.content] = $1
          end
        end

        unless root_nodes.empty?
          FileUtils.rm_f(file_name)
          File.open(file_name, 'w') do |f|
            f.write(root_nodes.to_yaml)
          end
        end
      else
        #todo correlate ECS locales to actual amazon.* urls
        raise "generating root nodes for locale's other than the US is not supported"
      end
    end

    def self.root_nodes(file_name = DEFAULT_ROOT_FILE)
      @root_nodes ||= File.open(file_name) { |yf| YAML::load(yf) }
    end

    # find a browse node based on its id
    # @param node_id [String] the browse node you're looking for
    # @returns [Ramazon::BrowseNode] the node you're looking for
    def self.find(node_id)
      req = Ramazon::Request.new(:operation => "BrowseNodeLookup", :browse_node_id => node_id)
      res = req.submit
      parse(res.to_s)[0]
    end

    # get a hash of name -> child browse_nodes
    # @returns [Hash] stringified hash of names => Ramazon::BrowseNode objects
    def child_hash
      if !@child_hash
        @child_hash = {}
        self.children.each do |i|
          @child_hash[i.name] = i
        end
      end

      @child_hash
    end

    def self.parse(xml, options = {})
      super
    end
  end
end
