require 'spec_helper'
require 'rspec'
require 'pipeline'

describe Pipeline do
  subject(:pipeline) { Pipeline.new }
  let(:resource) { double("resource") }
  let(:plan) { double("plan") }
  let(:job) { double("job") }
  let(:resource_hash) {
    {"name"=>"resource-to-add", "trigger"=>true}
  }
  let(:plan_hash) {
    [{"get" => "resource-to-get", "trigger" => true}, {"task"=>"task-to-perform", "config"=>{"platform"=>"some-platform", "image"=>"some-image", "run"=>{"path"=>"command","args"=>["cmd", "args"]}}}]
  }
  let(:job_hash) {
    {
      "name" => "job-to-add",
      "plan" => plan.get_hash
    }
  }

  context "when initializing a new pipeline" do
    it "successfully generates a skeleton for the pipeline" do
      expect(pipeline.get_hash).to eq([{"groups"=>[{"name"=>"all", "jobs"=>Array.new}]}, {"resources"=>Array.new}, {"jobs"=>Array.new}])
    end
  end

  context "when building the pipeline" do
    it "successfully adds a new resource" do
      allow(resource).to receive(:get_hash) { resource_hash }

      pipeline.add_resource(resource.get_hash)

      expect(pipeline.get_hash).to eq([
        {
          "groups" => [
            {"name" => "all", "jobs" => Array.new}
          ]
        },
        {
          "resources" => [
            {"name" => "resource-to-add", "trigger" => true}
          ]
        }, {
          "jobs" => Array.new
        }
      ])
    end

    it "successfully adds a new job" do
      allow(plan).to receive(:get_hash) { plan_hash }
      allow(job).to receive(:get_hash) { job_hash }

      pipeline.add_job(job.get_hash)

      expect(pipeline.get_hash).to eq([
        {
          "groups" => [
            { "name" => "all", "jobs" => Array.new }
          ]
        },
        {
          "resources" => Array.new
        },
        { 
          "jobs" => [
            {
              "name" => "job-to-add",
              "plan" => [
                {
                  "get" => "resource-to-get",
                  "trigger" => true
                },
                {
                  "task" => "task-to-perform",
                  "config" => {
                    "platform" => "some-platform", 
                    "image" => "some-image",
                    "run" => {
                      "path" => "command",
                      "args" => ["cmd", "args"]
                    }
                  }
                }
              ]
            }
          ]
        }
      ])
    end
  end

  it "successfully writes the pipeline to output stream in YAML" do
    file = StringIO.new
    allow(File).to receive(:open) { file }

    pipeline.finalize

    expect(file.string).to eq("---\n- groups:\n  - name: all\n    jobs: []\n- resources: []\n- jobs: []\n")
  end
end
