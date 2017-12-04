require 'carrierwave/orm/activerecord'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        # Configuration for Amazon S3
        # Sign up for an Amazon Web Services account [http://aws.amazon.com/].
        # Create a user via AWS Identity and Access Management (IAM) [http://aws.amazon.com/iam/]
        # and record the access key and secret key.
        # Create an S3 bucket (with a name of your choice) using the AWS Console [https://console.aws.amazon.com/s3],
        # and then grant read and write permission to the user created in the previous step.
        :provider              => 'AWS',
        :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
        :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }
    config.fog_directory     =  ENV['S3_BUCKET']
  end
end