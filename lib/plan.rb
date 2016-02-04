require 'yaml'

class Pipeline
  class Job
    class Plan

      class BadConfigError < StandardError; end

      def initialize
        @plan = []
      end

      def add_get(resource)
        @plan << resource.get_hash
      end

      def add_put(resource)
        @plan << resource.put_hash
      end

      def add_task(task_name, config, privileged=false)
        task = {}
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
