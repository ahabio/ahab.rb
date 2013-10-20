require 'multi_json'
require 'rake/tasklib'
require 'ahab'
require 'ahab/configuration'
require 'ahab/fetcher'

module Ahab

  class FetchTask < Rake::TaskLib

    attr_accessor :config_path

    def initialize(name = :fetch_assets)
      @name = name
      @config_path = 'ahab.json'
      yield self if block_given?
      define
    end

    private

    def define
      task @name => asset_tasks(Ahab::Configuration.from_file(config_path))
    end

    def asset_tasks(configuration)
      perform_task = perform_fetch_task(Ahab::Fetcher.new(configuration))

      configuration.assets.map do |asset|
        file asset.full_path => config_path do
          perform_task.invoke
        end
      end
    end

    def perform_fetch_task(fetcher)
      task(:__perform_fetch) do
        summary = fetcher.fetch do |asset|
          message = if asset.success?
            "Fetched #{asset.full_path}"
          else
            "Error fetching from #{asset.url}"
          end

          puts message
        end

        if summary.success?
          puts summary.to_s
        else
          abort summary.to_s
        end
      end
    end

  end

end
