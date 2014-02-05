# encoding: utf-8

module ArcServer
  module REST
    class Identify

      include HTTParty
      format :json
      # debug_output $stdout

      attr_accessor :params

      def initialize(attr={})
        @params = {
          f: "json",
          geometry: "",
          geometryType: "esriGeometryEnvelope",
          sr: "",
          layerDefs: "",
          time: "",
          layerTimeOptions: "",
          layers: "all",
          tolerance: "",
          mapExtent: "",
          imageDisplay: "",
          returnGeometry: true,
          maxAllowableOffset: ""
        }.merge(attr)
      end

      def execute(url)
        response = self.class.get("#{url}/identify", query: Util::ParamsFormatter.build(params))
        response.with_indifferent_access[:results].map { |r| IdentifyResult.new(r) }
      end

    end

    class IdentifyResult

      attr_accessor :layerId, :layerName, :value, :displayFieldName, :feature

      def initialize(attrs={})
        @layerId = attrs[:layerId]
        @layerName = attrs[:layerName]
        @value = attrs[:value]
        @displayFieldName = attrs[:displayFieldName]
        @geometryType = attrs[:geometryType]
        @geometry = ArcServer::Geometry::Geometry.build(attrs[:geometry], @geometryType)
        @feature = Graphics::Feature.new({ geometry: @geometry, attributes: attrs[:attributes] })
      end

    end

  end
end
