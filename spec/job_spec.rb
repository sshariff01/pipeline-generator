require 'spec_helper'
require 'rspec'
require 'plan'

describe Pipeline::Job do
  subject(:job) { Pipeline::Job.new }
  let(:job_name) { 'job-to-add' }
  let(:valid_plan) {
    [[{"task"=>"task-to-add", "config"=>{"platform"=>"some-platform", "image"=>"some-image", "run"=>{}}}]]
  }

  context "when defining a job to the pipeline" do
    it "successfully generates the YAML for a job with valid key-values: name, plan" do
      plan.add_get(resource_name)

      expect(plan.get_hash).to eq([[{"get"=>"some-resource"}]])
    end
  end
end

# name: string
# serial: boolean
# serial_groups: [string]
# max_in_flight: integer
# public: boolean
# plan: [step]
#
