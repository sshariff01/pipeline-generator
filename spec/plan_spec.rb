require 'spec_helper'
require 'rspec'
require 'plan'

describe Pipeline::Job::Plan do
  subject(:plan) { Pipeline::Job::Plan.new }
  let(:resource) { double('resource') }
  let(:task) { double('task') }
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

      expect(plan.get_hash).to eq([
        {
          "get"=> "dummy-resource-name",
        }
      ])
    end
  end

  context "when defining a put resource" do
    it "successfully inserts the put resource to the plan" do
      allow(resource).to receive(:put_hash) { put_resource_hash }

      plan.add_put(resource)

      expect(plan.get_hash).to eq([
        {
          "put" => "dummy-resource-name",
          "params" => {
              'first-key' => 'first-val',
              'second-key' => 'second-val'
          }
        }
      ])
    end
  end

  context "when defining a task(s)" do
    it "successfully inserts the task to the plan with keys: get, passed, trigger, params: task name, config" do
      allow(task).to receive(:get_hash) { task_hash }

      plan.add_task(task)

      expect(plan.get_hash).to eq([
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
      ])
    end
  end
end

