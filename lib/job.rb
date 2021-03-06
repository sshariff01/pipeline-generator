require 'yaml'

class Pipeline
  class Job
    def initialize(name, plan)
      @job = {
        "name" => name,
        "plan" => plan.get_hash
      }
    end

    def get_hash
      @job
    end
  end
end
