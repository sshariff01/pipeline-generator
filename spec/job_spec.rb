require 'spec_helper'
require 'rspec'
require 'job'

describe Job do
  subject(:job) { Job.new }

  context "when getting a resource" do
    it "successfully inserts YAML to the job with keys: get" do
      resource_name = 'some-resource'
      job.get(resource_name)
      expect(job).to eq(Hash.new)
    end
  end

end
