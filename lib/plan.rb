require 'yaml'

class Pipeline
  class Job
    class Plan

      class BadConfigError < StandardError; end

      def initialize
        @plan = Array.new
      end

      def add_get(resource_name, passed=nil, trigger=false, params=nil)
        get = Hash.new
        get["get"] = resource_name
        get["passed"] = passed if passed
        get["trigger"] = trigger if trigger
        get["params"] = params if !params.nil?
        @plan << get
      end

      def add_put(resource_name, params=nil)
        put = Hash.new
        put["put"] = resource_name
        put["params"] = params if !params.nil?
        @plan << put
      end

      def add_task(task_name, config, privileged=false)
        task = Hash.new
        task["task"] = task_name
        task["privileged"] = privileged if privileged
        valid_config(config) ? task["config"] = config : (raise BadConfigError)
        @plan << task
      end

      def get_hash
        @plan
      end

      private

      def valid_config(config)
        config["platform"] and config["image"] and config["run"]
      end
    end
  end
end
