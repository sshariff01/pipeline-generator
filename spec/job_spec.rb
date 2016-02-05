require 'spec_helper'
require 'rspec'
require 'job'

describe Pipeline::Job do
  subject(:job) { Pipeline::Job.new(job_name, plan) }
  let(:job_name) { 'job-name' }
  let(:plan) { double("plan") }
  let(:valid_plan) {
    [{"get" => "resource-to-get", "trigger" => true}, {"task"=>"task-to-perform", "config"=>{"platform"=>"some-platform", "image"=>"some-image", "run"=>{}}}]
  }

  context "when defining a pipeline job" do
    it "successfully generates the a job with valid key-values: name, plan" do
      allow(plan).to receive(:get_hash) { valid_plan }

      expect(job.get_hash).to eq({"name"=>"job-name", "plan"=>[{"get"=>"resource-to-get", "trigger"=>true}, {"task"=>"task-to-perform", "config"=>{"platform"=>"some-platform", "image"=>"some-image", "run"=>{}}}]})
    end
  end
end
