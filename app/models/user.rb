class User < ActiveRecord::Base
  belongs_to :room
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/uploads/users/missing.png"
  has_attached_file :avatar,
                    :storage => :cloudinary,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    :cloudinary_url_options => {
                        :default => {
                            :secure => true
                        }
                    },
                    :path => 'users/:id/:style/:filename'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
