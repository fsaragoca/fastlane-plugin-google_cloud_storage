require 'google/cloud/storage'

module Fastlane
  module Actions
    class GoogleCloudStorageUploadAction < Action
      def self.run(params)
        Actions.verify_gem!('google-cloud-storage')

        storage = Helper::GoogleCloudStorageHelper.setup_storage(
          project: params[:project],
          keyfile: params[:keyfile]
        )

        bucket = Helper::GoogleCloudStorageHelper.find_bucket(
          storage: storage,
          bucket_name: params[:bucket]
        )

        file_name = params[:name] || File.basename(params[:content_path])
        bucket.create_file(params[:content_path], file_name)
      end

      def self.description
        "Upload a file to Google Cloud Storage"
      end

      def self.authors
        ["Fernando Saragoca"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :project,
                                  env_name: "GOOGLE_CLOUD_STORAGE_PROJECT",
                               description: "Google Cloud Storage project identifier",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :keyfile,
                                  env_name: "GOOGLE_CLOUD_STORAGE_KEYFILE",
                               description: "Google Cloud Storage keyfile",
                                  optional: false,
                                      type: String,
                              verify_block: proc do |value|
                                              if value.nil? || value.empty?
                                                UI.user_error!("No keyfile for Google Cloud Storage action given, pass using `keyfile_path: 'path/to/file.txt'`")
                                              elsif File.file?(value) == false
                                                UI.user_error!("Keyfile '#{value}' not found")
                                              end
                                            end),
          FastlaneCore::ConfigItem.new(key: :bucket,
                                  env_name: "GOOGLE_CLOUD_STORAGE_BUCKET",
                               description: "Google Cloud Storage bucket",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :content_path,
                                  env_name: "GOOGLE_CLOUD_STORAGE_UPLOAD_CONTENT_PATH",
                               description: "Path for file to upload",
                                  optional: false,
                                      type: String,
                              verify_block: proc do |value|
                                              if value.nil? || value.empty?
                                                UI.user_error!("No content path for google_cloud_storage_upload action given, pass using `content_path: 'path/to/file.txt'`")
                                              elsif File.file?(value) == false
                                                UI.user_error!("File for path '#{value}' not found")
                                              end
                                            end),
          FastlaneCore::ConfigItem.new(key: :name,
                                  env_name: "GOOGLE_CLOUD_STORAGE_UPLOAD_NAME",
                               description: "File name",
                                  optional: true,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
