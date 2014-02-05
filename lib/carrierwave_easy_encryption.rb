require "carrierwave_easy_encryption/version"
require 'open-uri'

module CarrierWave
  module EasyEncryption
    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= CarrierWave::EasyEncryption::Configuration.new
    end

    class Configuration
      attr_accessor :password
    end

    module Uploader
      def self.secure_file(model=nil, file)
        if !model.nil? && model.id.nil?
          encrypted_file = Tempfile.new('enc').path
          cipher = Gibberish::AES.new(CarrierWave::EasyEncryption.configuration.password)
          cipher.encrypt_file(file, encrypted_file)
          FileUtils.copy(encrypted_file, file)
          File.unlink(encrypted_file)
          file
        end
      end
    end

    module Downloader
      class << self
        def download(uploader)
          cipher = Gibberish::AES.new(CarrierWave::EasyEncryption.configuration.password)

          is_local = (uploader._storage == CarrierWave::Storage::File)
          istream = open(is_local ? uploader.path : uploader.url)
          ostream = StringIO.new
          cipher.decrypt_stream(istream, ostream)
          return ostream
        end
      end
    end
  end
end
