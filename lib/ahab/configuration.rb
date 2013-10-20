require 'ahab/asset'
require 'multi_json'

module Ahab

  class Configuration

    def self.from_file(path)
      new MultiJson.decode(File.read(path))
    end

    attr_reader :assets

    def initialize(hash)
      @assets = hash.fetch('assets', []).map do |h|
        Ahab::Asset.new(h)
      end
    end

  end

end
