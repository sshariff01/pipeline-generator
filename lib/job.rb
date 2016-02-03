require 'yaml'

class Pipeline
  class Job
    def initialize
      @plan = Array.new
      @gets = Array.new
      @puts = Array.new
      @tasks = Array.new
    end
  end
end
