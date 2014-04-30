# encoding: utf-8

module ArcServer
  module REST
		class Query

      include HTTParty
      format :json
      # debug_output $stdout

      attr_accessor :params

			def initialize(attr={})
        @params = {
            where: "",
            objectIds: "",
            time: "",
            geometry: nil,
            geometryType: "esriGeometryEnvelope",
            inSR: "",
            spatialRel: "esriSpatialRelIntersects",
            relationParam: "",
            outFields: "*",
            returnGeometry: true,
            maxAllowableOffset: "",
            geometryPrecision: "",
            outSR: "",
            gdbVersion: "",
            returnIdsOnly: false,
            returnCountOnly: false,
            orderByFields: "",
            groupByFieldsForStatistics: "",
            outStatistics: "",
            returnZ: false,
            returnM: false,
            f: "json"
          }.merge(attr)
			end

      # Utility method that sanitize che query parameters
      # example:
      # where clause want that single quotes are double
      def sanitize_params
        # @where[/\w*=\'(.*)\'/].gsub(/\'/, "''")
        # @where.sub!(/\w*=\'(.*)\'/, { |s| puts s })
      end

      # Execute a query on a map layer
      # You have to specify a layer avaible on the map server:
      # http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Specialty/ESRI_StateCityHighway_USA/MapServer/0
      #
      def execute(url)
        response = self.class.get("#{url}/query", query: Util::ParamsFormatter.build(params))
        Graphics::FeatureSet.new(response.with_indifferent_access)
      end

		end
	end
end
