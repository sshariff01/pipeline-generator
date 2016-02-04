require 'spec_helper'
require 'rspec'
require 'plan'

describe Pipeline::Job::Plan do
  subject(:plan) { Pipeline::Job::Plan.new }
  let(:resource) { double('resource') }
  let(:task) { double('task') }
  let(:task2) { double('task') }
  let(:get_resource_hash) {
    {
      "get" => "dummy-resource-name",
      "passed" => ['passed-some-job'],
      "trigger" => true,
      "params" => {
          'first-key' => 'first-val',
          'second-key' => 'second-val'
      }
    }
  }
  let(:put_resource_hash) {
    {
      "put" => "dummy-resource-name",
      "resource" => "dummy",
      "params" => {
          'first-key' => 'first-val',
          'second-key' => 'second-val'
      }
    }
  }
  let(:task_hash) {
    {
      "task" => "dummy-task-name",
      "privileged" => true,
      "config" => {
        'platform' => 'some-platform',
        'image' => 'some-image',
        'inputs' => [
          {
            'name' => 'input1',
            'path' => 'input1/path'
          }
        ],
        'run' => {
          'path' => 'repo/scripts/test',
          'args' => ['arg0', 'arg1']
        }
      }
    }
  }

  context "when defining a get resource" do
    it "successfully inserts the get resource to the plan" do
      allow(resource).to receive(:get_hash) { get_resource_hash }

      plan.add_get(resource)

      expect(resource.get_hash).to have_key("passed")
      expect(resource.get_hash).to have_key("trigger")
      expect(plan.get_hash).to eq([get_resource_hash])
    end
  end

  context "when defining a put resource" do
    it "successfully inserts the put resource to the plan" do
      allow(resource).to receive(:get_hash) { put_resource_hash }

      plan.add_put(resource)

      expect(resource.get_hash).to have_key("resource")
      expect(plan.get_hash).to eq([put_resource_hash])
    end
  end

  context "when defining a task(s)" do
    it "successfully inserts a single task to the plan with keys: get, passed, trigger, params: task name, config" do
      allow(task).to receive(:get_hash) { task_hash }

      plan.add_task(task)

      expect(plan.get_hash).to eq([task_hash])
    end

    it "successfully inserts more than one task to the plan with keys: get, passed, trigger, params: task name, config" do
      allow(task).to receive(:get_hash) { task_hash }
      allow(task2).to receive(:get_hash) { task_hash }

      plan.add_tasks([task, task2])

      expect(plan.get_hash).to eq([task_hash, task_hash])
    end

    it "fails to inserts more than one task if arg is not an array" do
      allow(task).to receive(:get_hash) { task_hash }

      expect{plan.add_tasks("garbage")}.to raise_error(Pipeline::Job::Plan::ImproperArgFormatError)
    end
  end
end

