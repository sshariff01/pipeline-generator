class Pipeline
  class Job
    class Plan
      def initialize
        @plan = []
      end

      def add_get(resource)
        @plan << get_resource(resource)
      end

      def add_put(resource)
        @plan << resource.put_hash
      end

      def add_task(task)
        @plan << task.get_hash
      end

      def get_hash
        @plan
      end

      private

      def get_resource(resource)
        {
          "get" => resource.get_hash["get"]
        }
      end
    end
  end
end
