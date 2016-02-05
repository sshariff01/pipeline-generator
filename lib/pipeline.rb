require 'yaml'

class Pipeline
  def initialize(filename='generated_pipeline.yml')
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
    @filename = filename
  end

  def add_resource(resource)
    @pipeline["resources"] << resource.get_hash
  end

  def add_job(job)
    @pipeline["jobs"] << job.get_hash
    @pipeline["groups"].each do |group|
      if group["name"].eql? "all"
        group["jobs"] << job.get_hash["name"]
        break
      end
    end
  end

  def finalize
    output=output_file
    output.puts(@pipeline.to_yaml)
    output.close
    output_file_contents
  end

  def output_file
    File.open(@filename, "w")
  end

  def get_hash
    @pipeline
  end

  private

  def output_file_contents
    File.open(@filename).each do |line|
      p line
    end
  end
end
