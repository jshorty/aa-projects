class Contact < ActiveRecord::Base
  validates :email, :user_id, :name, :presence => true
  validates :email, :uniqueness => {:scope => :user_id}

  belongs_to :owner,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  has_many :contact_shares,
    class_name: "ContactShare",
    primary_key: :id,
    foreign_key: :contact_id

  has_many :shared_users,
    through: :contact_shares,
    source: :user

  has_many :comments,
    as: :commentable,
    class_name: "Comment",
    primary_key: :id,
    foreign_key: :commentable_id

  has_many :groupings,
    class_name: "GroupedContact",
    primary_key: :id,
    foreign_key: :contact_id

  has_many :groups,
    through: :groupings,
    source: :group
end
