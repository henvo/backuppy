# Setup mail defaults
#
Mail.defaults do
  retriever_method :pop3,
    address: ENV['MAIL_ADDRESS'],
    port: ENV['MAIL_PORT'],
    user_name: ENV['MAIL_USERNAME'],
    password: ENV['MAIL_PASSWORD'],
    enable_ssl: true
end

