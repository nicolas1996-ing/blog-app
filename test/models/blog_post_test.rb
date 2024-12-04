# == Schema Information
#
# Table name: blog_posts
#
#  id           :bigint           not null, primary key
#  published_at :datetime
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"


# conditions for the methods:
# blog_post.published? when published_at is not nil and published_at is less than or equal to Time.zone.now
# blog_post.scheduled? when published_at is not nil and published_at is greater than Time.zone.now
# blog_post.draft? when published_at is nil

class BlogPostTest < ActiveSupport::TestCase
 test "draft? returns true for draft blog post" do 
  # binding.irb # next and exit to continue
  assert blog_posts(:draft).draft? # using the blog_post.yml fixture (:draft)
 end

 test "draft? returns false for published blog post" do 
  assert_not BlogPost.new(title:"test", body: "title", published_at: Time.current).draft?
 end

 test "published? returns true for published blog post" do
  assert published_blog_post.published?
 end

 test "published? returns false for draft blog post" do
  assert_not BlogPost.new(title:"test", body: "title", published_at: nil).published?
 end

 test "scheduled? returns true for scheduled blog post" do
  assert blog_posts(:scheduled).scheduled? # using the blog_post.yml fixture (:scheduled)
 end

 test "scheduled? returns false for published blog post" do
  assert_not BlogPost.new(title:"test", body: "title", published_at: Time.current).scheduled?
 end

 # custom methods
 
 def draft_blog_post 
  BlogPost.new(title:"test", body: "title", published_at: nil)
 end

 def published_blog_post
  BlogPost.new(title:"test", body: "title", published_at: Time.current)
 end
end
