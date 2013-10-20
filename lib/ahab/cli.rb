require 'thor'
require 'ahab/configuration'
require 'ahab/fetcher'

module Ahab
  class CLI < Thor

    include Thor::Actions

    desc 'fetch', 'fetch assets'
    def fetch
      summary = Ahab::Fetcher.new(load_config).fetch do |a|
        if a.success?
          say_status 'fetch', "Wrote #{a.filename}"
        else
          say_status 'fetch', "Error fetching #{a.url}", :red
        end
      end

      say_status 'fetch', summary.to_s, summary.success? ? :green : :red

      exit 1 unless summary.success?
    end

    private

    def load_config
      path = 'ahab.json'

      unless File.exists?(path)
        say_status 'fetch', 'Could not find ahab.json', :red
        exit 1
      end

      Ahab::Configuration.from_file path
    end

  end
end
