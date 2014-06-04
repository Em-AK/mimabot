gem "minitest"
require "minitest/autorun"
require "mail"
require "./models"
require "pry"

class TestPost < Minitest::Test

  def setup
    sample = Mail.read('./sample_message')
    @post = Post.new(sample)
  end

  def test_post_exist
    assert_equal false, @post.nil?
  end

  def test_no_div_in_post_content
    assert_equal nil, @post.content =~ /div>/
  end

  def test_there_is_2_fragments
    assert_equal 2, @post.fragments.count
  end
  
  def test_fragments_exist
    assert_equal Fragment, Fragment.last.class
  end

  def test_tag_extraction

  end
end

