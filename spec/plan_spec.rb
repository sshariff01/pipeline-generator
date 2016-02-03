require 'spec_helper'
require 'rspec'
require 'plan'

describe Pipeline::Job::Plan do
  subject(:plan) { Pipeline::Job::Plan.new }
  let(:resource_name) { 'some-resource' }

  context "when defining a get resource" do
    it "successfully inserts YAML to get the plan with keys: get" do
      plan.add_get(resource_name)

      expect(plan.get_hash).to eq([{"get"=>"some-resource"}])
    end

    it "successfully inserts YAML to get the plan with keys: get, passed" do
      passed = [ 'some-other-job' ]

      plan.add_get(resource_name, passed)

      expect(plan.get_hash).to eq([{"get"=>"some-resource", "passed"=>["some-other-job"]}])
    end

    it "successfully inserts YAML to get the plan with keys: get, passed, trigger" do
      passed = [ 'some-other-job' ]
      trigger = true

      plan.add_get(resource_name, passed, trigger)

      expect(plan.get_hash).to eq([{"get"=>"some-resource", "passed"=>["some-other-job"], "trigger"=>true}])
    end

    it "successfully generates the YAML for getting a resource with keys: get, passed, trigger, params" do
      passed = [ 'some-other-job' ]
      trigger = true
      params = {
        'first-key' => 'first-val',
        'second-key' => 'second-val'
      }

      plan.add_get(resource_name, passed, trigger, params)

      expect(plan.get_hash).to eq([{"get"=>"some-resource", "passed"=>["some-other-job"], "trigger"=>true, "params"=>{"first-key"=>"first-val", "second-key"=>"second-val"}}])
    end
  end

  context "when defining a put resource" do
    it "successfully inserts YAML to put the plan with keys: resource name" do
      plan.add_put(resource_name)

      expect(plan.get_hash).to eq([{"put"=>"some-resource"}])
    end

    it "successfully generates the YAML for putting a resource with keys: resource name, params" do
      params = {
        'first-key' => 'first-val',
        'second-key' => 'second-val'
      }

      plan.add_put(resource_name, params)

      expect(plan.get_hash).to eq([{"put"=>"some-resource", "params"=>{"first-key"=>"first-val", "second-key"=>"second-val"}}])
    end
  end

  context "when defining a task" do
    it "successfully generates the YAML for running a task with keys: task name, config" do
      task_name = 'task-to-add'
      config = {
        'platform' => 'some-platform',
        'image' => 'some-image',
        'run' => {}
      }

      plan.add_task(task_name, config)

      expect(plan.get_hash).to eq([{"task"=>"task-to-add", "config"=>{"platform"=>"some-platform", "image"=>"some-image", "run"=>{}}}])
    end

    it "fails and throws an error when a task config is ill defined" do
      task_name = 'task-to-add'
      config = {
        'platform' => 'some-platform',
        'image' => 'some-image',
        'missing-run-key' => {}
      }

      expect{plan.add_task(task_name, config)}.to raise_error(Pipeline::Job::Plan::BadConfigError)

    end
  end
end

