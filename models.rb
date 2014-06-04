ActiveRecord::Base.establish_connection(
  :adapter  => :sqlite3,
  :database => 'development.sqlite3'
)

class Post
  def receive(message, params)
    @message = message  
    self.fragments
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
      f.save
    end
  end
end

class Fragment < ActiveRecord::Base

  def extract_tags
    self.tags = self.content.scan(/#\w*/).to_s
  end

  def show
    @fragment = Fragment.all 
  end
end