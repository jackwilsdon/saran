module Saran
  class ClassLoader
    attr_reader :files

    def initialize
      @files = {}
    end

    def load(filename)
      @files[filename] = get_file_module filename
    end

    def classes
      all_classes = []

      files.values.each do |mod|
        mod.constants.each do |const_name|
          const_value = mod.const_get const_name

          next unless const_value.is_a? Class

          all_classes.push const_value
        end
      end

      all_classes
    end

    private

    def get_file_module(filename)
      mod = Module.new
      mod.instance_eval File.read(filename), filename

      mod
    end
  end
end
