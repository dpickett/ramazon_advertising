module Ramazon
  class BrowseNode
    include HTTParty

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
  end
end
