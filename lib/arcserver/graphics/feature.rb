module ArcServer
	module Graphics
    class Feature

      attr_accessor :geometry, :attributes

      def initialize(attr={})
        @geometry = attr[:geometry]
        @attributes = attr[:attributes] || { }
      end

      def self.create(json)
        parsed = (json.is_a?(Hash) ? json : JSON.parse(json)).with_indifferent_access
        Feature.new({ geometry: ArcServer::Geometry::Geometry.create(parsed['geometry']), attributes: parsed['attributes'] })
      end

    end
	end
end
