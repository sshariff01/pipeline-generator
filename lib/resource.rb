class Pipeline
  class Resource

    class BadResourceConfigError < StandardError; end

    def initialize
      @resource = {}
    end

    def configure(name, type, source)
      (!name.nil? && !name.empty?) ? @resource["name"] = name : (raise BadResourceConfigError)
      (!type.nil? && !type.empty?) ? @resource["type"] = type : (raise BadResourceConfigError)
      (!source.nil? && !source.empty?) ? @resource["source"] = source : {}
    end

    def add_source_param(k, v)
      source = @resource["source"].nil? ? {} : @resource["source"]
      @resource["source"] = source.merge!({k => v})
    end

    def get_hash
      @resource
    end
  end
end
