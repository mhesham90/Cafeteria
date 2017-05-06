class Product < ApplicationRecord
  belongs_to :category
  has_many :orderdetails
  has_many :orders, through: :orderdetails
  has_attached_file :avatar,
                    :storage => :cloudinary,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    :cloudinary_url_options => {
                        :default => {
                            :secure => true
                        }
                    },
                    :path => 'products/:id/:style/:filename'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  after_create ->{
    ProductCreateJob.perform_now(self.to_json)
  }
  after_update_commit ->{
    ProductChangeJob.perform_now(self.to_json)
  }
  before_destroy ->{
    ProductDestroyJob.perform_now(self.to_json)
  }
end
