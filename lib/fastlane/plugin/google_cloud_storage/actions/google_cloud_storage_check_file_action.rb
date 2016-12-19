require 'google/cloud/storage'

module Fastlane
  module Actions
    class GoogleCloudStorageCheckFileAction < Action
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

        begin
          Helper::GoogleCloudStorageHelper.find_file(
            bucket: bucket,
            file_name: params[:file_name]
          )
          true
        rescue
          false
        end
      end

      def self.description
        "Check if file exists in Google Cloud Storage"
      end

      def self.authors
        ["Fernando Saragoca"]
      end

      def self.return_value
        "Returns 'true' if object exists, 'false' if not"
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
          FastlaneCore::ConfigItem.new(key: :file_name,
                                  env_name: "GOOGLE_CLOUD_STORAGE_DOWNLOAD_FILE_NAME",
                               description: "File name",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
