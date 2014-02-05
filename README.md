# CarrierWave::EasyEncryption

The easiest way to encrypt files uploaded to Rails when you're storing with CarrierWave.

Based on `carrierwave_securefile`, but simpler.

Tested with Ruby 2 and Rails 4.

## Installation

Add this line to your application's Gemfile:

    gem 'carrerwave_easy_encryption'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrerwave_easy_encryption

## Usage

###Add an initializer###

    CarrierWave::EasyEncryption.configure do |config|
      config.password = "<some long hex digits, e.g. the output of SecureRandom.hex(32)>"
    end`

###Modify the uploaders you want to encrypt###

    class MyUploader < CarrierWave::Uploader::Base
      process :encrypt

      def encrypt
        CarrierWave::EasyEncryption::Uploader.secure_file(model, self.file.path.to_s)
      end
    end

###Add controller actions for decrypting files before downloading###

    def download
      @model = Model.find(params(:id))
      send_data CarrierWave::EasyEncryption::Downloader.download(@model.my_uploader).string, filename: File.basename(@model.my_uploader.path)
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
