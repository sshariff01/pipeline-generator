class Pipeline
  class Job
    class Plan
      def initialize
        @plan = []
      end

      def add_get(resource)
        @plan << resource.get_hash
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
    end
  end
end
