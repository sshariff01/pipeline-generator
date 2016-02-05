require 'spec_helper'
require 'rspec'
require 'resource'

describe Pipeline::Resource do
  subject(:resource) { Pipeline::Resource.new }
  let(:name) { "dummy-resource" }
  let(:type) { "dummy-type" }
  let(:source) { 
    {
      'first-param' => 'first-val',
      'second-param' => 'second-val'
    }
  }

  context "when defining a resource" do
    it "successfully generates the configuration for a resource" do
      resource.configure(name, type, source)

      expect(resource.get_hash).to eq(
        {
          "name"=> "dummy-resource",
          "type" => "dummy-type",
          "source" => {
              'first-param' => 'first-val',
              'second-param' => 'second-val'
          }
        }
      )
    end

    it "fails to generate the configuration for a resource when no name is provided" do
      expect{resource.configure("", type, source)}.to raise_error(Pipeline::Resource::BadResourceConfigError)
    end
  end

  context "when defining a resource's source" do
    it "successfully defines the source with any number of key-value pairs" do
      resource.configure(name, type, "")
      resource.add_source_param("first-param", "first-val")
      resource.add_source_param("second-param", "second-val")

      expect(resource.get_hash["source"]).to eq(
        {
          "first-param" => "first-val",
          "second-param" => "second-val"
        }
      )
    end
  end
end
