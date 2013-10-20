require 'fileutils'
require 'uri'
require 'ahab'

module Ahab

  class NoAssetURL < StandardError
    def initialize(asset)
      super("No URL in asset #{asset}")
    end
  end

  class InvalidAssetURL < StandardError
    def initialize(url)
      super("#{url} is not a valid URL")
    end
  end

  class CannotInferFilename < StandardError
    def initialize(url)
      super("Cannot infer filename from #{url}")
    end
  end

  class Asset

    attr_reader :filename, :full_path, :status

    def initialize(hash)
      @uri = parse_uri(hash['url'])
      @filename = hash.fetch('filename') { infer_filename(@uri) }
      # TODO: inject this:
      @destination_directory = 'vendor/assets'
      @full_path = File.join(@destination_directory, @filename)
      @status = :unfetched
    end

    def url
      @uri.to_s
    end

    def write!(content)
      FileUtils.mkdir_p @destination_directory
      File.write @full_path, content
      @status = :fetched
    end

    def error!
      @status = :error
    end

    def success?
      @status == :fetched
    end

    private

    def destination_directory
      # todo: pass this in from the configuration
      'vendor/assets'
    end

    def parse_uri(url)
      raise NoAssetURL.new(self) unless url
      URI.parse(url).tap do |uri|
        raise InvalidAssetURL.new(url) unless uri.is_a?(URI::HTTP)
      end
    end

    def infer_filename(uri)
      uri.path.split('/').last or raise CannotInferFilename.new(uri)
    end

  end

end
