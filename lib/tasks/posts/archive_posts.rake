namespace :posts do
  desc 'Archives all expired posts'
  task archive_posts: :environment do
    Post.all.each do |post|
      post.archive
      post.save!
    end
  end
end
