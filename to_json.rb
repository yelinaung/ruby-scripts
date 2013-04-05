require 'nokogiri'
require 'json'

class Nokogiri::XML::Node
    def to_json(*a)
        {"curr"=>name}.tap do |h|
            kids = children.to_a

