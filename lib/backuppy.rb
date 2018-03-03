# frozen_string_literal: true

require 'thor'
require 'mail'
require 'logging'

require "backuppy/version"
require "backuppy/initializer"

module Backuppy
  class << self
    attr_accessor :logger
  end

  def self.logger
    @logger ||= Logging.logger(ENV['LOGFILE'])
  end

  class CLI < Thor
    desc 'start', 'Start the service'
    def start
      Backuppy.logger.info "Started the service"

      loop do
        # Get all the mails
        emails = Mail.all

        if emails.length > 0

          Backuppy.logger.info "Fetched #{emails.length} new mails"

          emails.each do |mail|
            Backuppy.logger.info "Checking mail from #{mail.from}"

            # Get all the allowed senders from ENV variable
            whitelist = ENV['ALLOWED_SENDERS'].gsub(' ', '').split(',')
            next unless (mail.from - whitelist).empty?

            # Return if no attachments available
            next unless mail.multipart?

            # Iterate over all attachments
            mail.attachments.each do |attachment|

              next unless attachment.content_type.start_with?('image/')

              # Extract filename from attachment
              filename = "#{ENV['BACKUP_DIR']}/#{attachment.filename}"
              begin
                File.open(filename, 'w+b', 0644) do |f|
                  Backuppy.logger.info "Writing #{filename} to #{'BACKUP_DIR'}"
                  f.write attachment.decoded
                end
              rescue => e
                Backuppy.logger.warn "Could not save file: #{e}"
              end
            end
          end

          # Delete all messages
          Backuppy.logger.info 'Deleting all mails'
          Mail.delete_all

        end

        sleep ENV['FETCH_INTERVAL'].to_i || 60
      end
    end
  end
end
