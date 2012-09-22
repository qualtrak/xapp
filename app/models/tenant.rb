class Tenant < ActiveRecord::Base
  belongs_to :account
  attr_accessible :account_id, :active, :description, :name

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true, numericality: { greater_than_or_equal_to: 1000 }

  def initialize(attributes = nil, options = {})
    super
    self.active = true
  end

  class << self
    def find_or_new(id)
      raise TypeError, 'The id must be an integer!' unless id.is_a? Integer

      if id == 0
        Tenant.new
      else
        Tenant.find(id)
      end
    end

    def create_and_return_model(tenant)
      tenant.code = 1000
      tenant.save
      tenant
    end
  end
end
