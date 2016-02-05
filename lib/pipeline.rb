require 'yaml'

class Pipeline
  def initialize
    @pipeline = {
      "groups" => [
        {
          "name" => "all",
          "jobs" => []
        }
      ],
      "resources" => [],
      "jobs" => []
    }
  end

  def add_resource(resource)
    @pipeline["resources"] << resource
  end

  def add_job(job)
    @pipeline["jobs"] << job
  end

  def finalize
    output=output_file
    output.puts(@pipeline.to_yaml)
    output.close
  end

  def output_file(filename='generated_pipeline.yml')
    File.open(filename, "w")
  end

  def get_hash
    @pipeline
  end
end
