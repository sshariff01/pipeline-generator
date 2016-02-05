require 'spec_helper'
require 'rspec'
require 'task'

describe Pipeline::Job::Plan::Task do
  subject(:task) { Pipeline::Job::Plan::Task.new }
  let(:name) { "dummy-task" }
  let(:file) { "some/task/config.yml" }
  let(:config) {
    {
      "platform" => "os",
      "image" => "docker:///public-image",
      "inputs" => [
        {
          "name" => "input1",
          "path" => "/path/of/input1",
        }
      ],
      "run" => {
        "path" => "path/of/thing/to/run/cmd",
        "args" => ["arg0", "arg1"]
      }
    }
  }

  context "when defining a task" do
    it "successfully generates the configuration for a task given: task name, config" do
      task.configure(name, config, "")

      expect(task.get_hash).to eq(
        {
          "task" => name,
          "config" => config
        }
      )
    end

    it "successfully generates the configuration for a task given: task name, file" do
      task.configure(name, "", file)

      expect(task.get_hash).to eq(
        {
          "task" => name,
          "file" => file
        }
      )
    end

    it "successfully generates the configuration for a task given: task name, config, file" do
      task.configure(name, config, file)

      expect(task.get_hash).to eq(
        {
          "task" => name,
          "file" => file,
          "config" => config
        }
      )
    end

    it "fails to generate the configuration for a task when not given a task name" do
      expect{task.configure("", config, file)}.to raise_error(Pipeline::Job::Plan::Task::BadTaskConfigError)
    end

    it "fails to generate the configuration for a task when not given config or file" do
      expect{task.configure(name, "", "")}.to raise_error(Pipeline::Job::Plan::Task::BadTaskConfigError)
    end
  end

  context 'when defining a task config' do
    before(:each) do
      platform = "linux"
      image = "docker:///ubuntu#14.04"
      inputs = {
        "name" => "my-repo",
        "path" => "path/to/mount",
      }
      run = {
        "path" => "my-repo/scripts/test",
        "args" => ["arg0", "arg1"]
      }
    end

    it "successfully generates the config" do
      expect(task.generate_config(:platform, :image, :inputs, :run)).to eq(
        {
          "platform" => :platform,
          "image" => :image,
          "inputs" => :inputs,
          "run" => :run
        }
      )
    end
  end
end

