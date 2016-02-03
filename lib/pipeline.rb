require 'yaml'

class Pipeline
  def initialize
    @pipeline = [
      { 
        "groups" => [
          {
            "name" => "all",
            "jobs" => Array.new
          }
        ]
      },
      {
        "resources" => Array.new
      },
      {
        "jobs" => Array.new
      }
    ]
  end

  def add_resource(resource)
    @pipeline.each do |section|
      if section["resources"]
        section["resources"] << resource
      end
    end
  end

  def add_job(job)
    @pipeline.each do |section|
      if section["jobs"]
        section["jobs"] << job
      end
    end
  end

  def get_hash
    @pipeline
  end
end
