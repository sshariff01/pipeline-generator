class Pipeline
  class Job
    class Plan

      class ImproperArgFormatError < StandardError; end

      def initialize
        @plan = []
      end

      def add_get(resource)
        @plan << get_resource(resource)
      end

      def add_put(resource)
        @plan << put_resource(resource)
      end

      def add_task(task)
        @plan << task.get_hash
      end

      def add_tasks(tasks)
        begin
          tasks.each do |task|
            @plan << task.get_hash
          end
        rescue
          raise ImproperArgFormatError
        end
      end

      def get_hash
        @plan
      end

      private

      def get_resource(resource)
        {
          "get" => resource.get_hash["get"],
          "params" => resource.get_hash["params"]
        }. tap do |hash|
          hash["passed"] = resource.get_hash["passed"] if resource.get_hash.key? "passed"
          hash["trigger"] = resource.get_hash["trigger"] if resource.get_hash.key? "trigger"
        end
      end

      def put_resource(resource)
        {
          "put" => resource.get_hash["put"],
          "params" => resource.get_hash["params"]
        }.tap do |hash|
          hash["resource"] = resource.get_hash["resource"] if resource.get_hash.key? "resource"
        end
      end
    end
  end
end
