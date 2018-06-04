require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @posts = posts
  end

  test "posts are archived on expire" do
    @posts.each do |p|
      p.archive
      if (p.expire_date < Time.now)
        assert p.archived
      else
        assert !p.archived
      end
    end
  end

end
