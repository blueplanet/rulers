require 'multi_json'

module Rulers
  module Model
    class FileModel
      def initialize(filename)
        @file = filename

        basename = File.split(filename)[-1]
        @id = File.basename(basename, '.json').to_i

        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end

      def self.all
        files = Dir["db/quotes/*.json"]
        files.map { |f| FileModel.new f }
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @has[name.to_s] = value
      end

      def self.find(id)
        FileModel.new("db/quotes/#{id}.json")
      rescue
        return nil
      end
    end
  end
end
