class Account < ActiveRecord::Base
  has_many :tenants
  attr_accessible :active, :email, :name

  validates :name, presence: true
  validates :email, presence: true

  def initialize(attributes = nil, options = {})
    super
    self.active = true
  end

  class << self
    def find_or_new(id)
      raise TypeError, 'The id must be an integer!' unless id.is_a? Integer

      if id == 0
        Account.new
      else
        Account.find(id)
      end
    end

    def create_and_return_model(account)
      account.save
      account
    end
  end
end
