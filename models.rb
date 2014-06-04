
# Change the following to reflect your database settings
#ActiveRecord::Base.establish_connection(
#  adapter:  'sqlite3',
#  host:     'localhost',
#  database: 'development',
#)


class Post
  def receive(message, params)
    @message = message  
  end

  def content
    @message.body.parts.select{ |p| p.content_type =~ /plain/}.first.decoded
  end

  def timestamp
    @message.date
  end

  def fragments
    fragments = [""]
    self.content.gsub(/(\n){3,}/, "\n\n").lines.each do |line|
      if line.strip.empty?
        fragments << nil # append a new fragment if the current line is empty
      else
        fragments[-1] = fragments[-1].to_s + line
      end
    end
    fragments.compact.each do |content|
      f = Fragment.new(content: content, timestamp: self.timestamp)
      f.extract_tags
    binding.pry
    end
  end
end

class Fragment
  attr_accessor :timestamp, :content, :tags
  def initialize(params)
    @content = params[:content]
    @timestamp = params[:timestamp]
  end

  def extract_tags
    self.tags = self.content.scan(/#\w*/)
  end
end
