class Pipeline
  class Resource

    class BadResourceConfigError < StandardError; end

    def initialize
      @resource = {}
    end

    def configure(name, type, source)
      (!name.nil? && !name.empty?) ? @resource["name"] = name : (raise BadResourceConfigError)
      (!type.nil? && !type.empty?) ? @resource["type"] = type : (raise BadResourceConfigError)
      (!source.empty?) ? @resource["source"] = source : (raise BadResourceConfigError)
    end

    def get_hash
      @resource
    end
  end
end
