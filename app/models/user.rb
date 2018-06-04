class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable #uncomment to restore email validation

  def timeout_in
    if is_admin?
      return 5.minutes
    else
      return 5.years
    end
  end


  validates :email, uniqueness: true
  validates :password, :presence => false, :on => :edit

  serialize :saved_posts
  has_many :posts

  def toggle_save(selected_post)
    if self.posts.include? selected_post
      self.posts.delete(selected_post)
    else
      self.posts << selected_post
    end
  end
end
