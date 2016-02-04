class Pipeline
  class Job
    class Plan
      class Task

        class BadTaskConfigError < StandardError; end

        def initialize
          @task = {}
        end

        def configure(name, config, file)
          (!name.nil? && !name.empty?) ? @task["task"] = name : (raise BadTaskConfigError)
          @task["file"] = file if (!file.nil? && !file.empty?)
          @task["config"] = config if (!config.empty?)

          raise BadTaskConfigError if !@task.has_key? "config" and !@task.has_key? "file"
        end

        def get_hash
          @task
        end
      end
    end
  end
end
