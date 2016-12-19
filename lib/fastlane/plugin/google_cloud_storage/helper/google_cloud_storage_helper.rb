require 'google/cloud/storage'

module Fastlane
  module Helper
    class GoogleCloudStorageHelper
      def self.setup_storage(project: nil, keyfile: nil)
        Google::Cloud::Storage.new(
          project: project,
          keyfile: keyfile
        )
      rescue
        UI.user_error! "Invalid Google Cloud Storage credentials 🚫"
      end

      def self.find_bucket(storage: nil, bucket_name: nil)
        bucket = storage.bucket(bucket_name)
        if bucket.nil?
          UI.user_error! "Bucket '#{bucket_name}' not found 🚫"
        end
        bucket
      end

      def self.find_file(bucket: nil, file_name: nil)
        file = bucket.file(file_name)
        if file.nil?
          UI.user_error! "Object '#{file_name}' not found 🚫"
        end
        file
      end
    end
  end
end
