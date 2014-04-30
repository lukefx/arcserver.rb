module ArcServer
  module Util
    class ParamsFormatter

      def self.build(params)
        hash = params.dup
        if hash[:geometry]
          hash[:geometryType] = hash[:geometry].geometryType
          hash[:geometry] = hash[:geometry].to_json
        end
        hash[:mapExtent] = hash[:mapExtent].join(',') if hash[:mapExtent]
        hash
      end

    end
  end
end
