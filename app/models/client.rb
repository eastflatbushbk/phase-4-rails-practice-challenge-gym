class Client < ApplicationRecord
    has_many :memberships, dependent: :destroy
    has_many :gyms, through: :memberships
    validates :name, presence: true
    validates :age, presence: true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 18, :message => '-> Must be older than 18 to sign up'}

    def total_memberships
        " #{self.memberships.count}"
      end
end
