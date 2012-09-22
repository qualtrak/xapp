FactoryGirl.define do
  factory :tenant do
    name 'Tenant 1000'
    code 1000
    description 'The Host Tenant'

    factory :tenant1 do
      name 'Tenant 1001'
      code 1001
    end
  end
end
