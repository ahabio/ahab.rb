require 'typhoeus'
require 'ahab'

module Ahab

  class Fetcher

    def initialize(configuration)
      @configuration = configuration
    end

    def fetch(&on_fetched)
      fetch_all @configuration.assets, &on_fetched
    end

    private

    def client
      @client ||= Typhoeus::Hydra.hydra
    end

    def fetch_all(assets, &on_fetched)
      requests(assets, &on_fetched).each { |request| client.queue request }
      client.run
      FetchSummary.new(assets)
    end

    def requests(assets, &on_fetched)
      assets.map do |asset|
        Typhoeus::Request.new(asset.url).tap do |request|
          request.on_complete do |response|
            if response.success?
              asset.write! response.body
            else
              asset.error!
            end

            on_fetched.call(asset) if on_fetched
          end
        end
      end
    end

  end

  class FetchSummary
    MESSAGE = 'Fetched %s. Failed to fetch %s.'

    def initialize(assets)
      @assets = assets
    end

    def success?
      @success ||= @assets.all?(&:success?)
    end

    def to_s
      @message = begin
        successful_count = @assets.select(&:success?).length
        failed_count     = @assets.length - successful_count

        MESSAGE % [ asset_count(successful_count), asset_count(failed_count) ]
      end
    end

    private

    def asset_count(count)
      count == 1 ? '1 asset' : "#{count} assets"
    end
  end

end
