class Pipeline
  class Job
    class Plan
      class Task

        class BadTaskConfigError < StandardError; end

        def initialize
          @task = {}
        end

        def configure(name, config=nil, file=nil)
          (!name.nil? && !name.empty?) ? @task["task"] = name : (raise BadTaskConfigError)
          @task["file"] = file if (!file.nil? && !file.empty?)
          @task["config"] = config if (!config.nil? && !config.empty?)

          raise BadTaskConfigError if !@task.has_key? "config" and !@task.has_key? "file"
        end

        def generate_config(platform, image, inputs, run)
          @task["config"] = {
            "platform" => platform,
            "image" => image,
            "inputs" => inputs,
            "run" => run
          }
        end

        def get_hash
          @task
        end
      end
    end
  end
end
