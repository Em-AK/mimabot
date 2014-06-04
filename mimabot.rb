require "mailman"
require "pry"
require "./models.rb"

# IMAP polling configuration
Mailman.config.imap = {
  server: '...',
  port: 143,
  username: '...',
  password: '...',
  ssl: false
}
Mailman.config.poll_interval = 20

# run the app
Mailman::Application.run do
  to 'mm@bepos.be' do
    post = Post.new(message)
    post.fragments.each do |fragment|
      puts "#{fragment}\n"
    end
  end
end

