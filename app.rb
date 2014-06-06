require "mailman"
require "pry"
require "dotenv"
require "./models.rb"

Dotenv.load

Mailman.config.imap = {
  server: ENV['server'],
  port: 143,
  username: ENV['username'],
  password: ENV['password'],
  ssl: false
}

Mailman.config.poll_interval = 2

# run the app
Mailman::Application.run do
  to 'mm@bepos.be', Post
end


