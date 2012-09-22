require 'spec_helper'

describe Tenant do
  let :tenant do
    build(:tenant)
  end

  subject do
    tenant
  end

  it 'is #active by default' do
    tenant.active.should be_true
  end

  it 'is valid' do
    should be_valid
  end

  context 'is invalid' do
    it 'when #name is not given' do
      tenant.name = ''
      should_not be_valid
    end

    it 'when #code is not given' do
      tenant.code = nil
      should_not be_valid
    end

    it 'when #code is less then 1000' do
      tenant.code = 999
      should_not be_valid
    end

    it 'when #code is not unique' do
      tenant.save
      tenant1 = build(:tenant)
      tenant1.save
      tenant1.errors.full_messages[0].should match 'Code has already been taken'
      tenant1.should_not be_valid
    end

    it 'when #code is mass assigned' do
      lambda { Tenant.new(code: 1001) }.should raise_error ActiveModel::MassAssignmentSecurity::Error
    end
  end

  context 'can find by id or add new when id is 0' do
    it '.find_or_new id argument must be integer' do
      lambda { Tenant.find_or_new('x') }.should raise_error TypeError, 'The id must be an integer!'
    end

    it '.find_or_new should instantiate new Tenant when id is 0' do
      new_tenant = Tenant.find_or_new(0)
      new_tenant.should be_active
    end

    it '.find_or_new should find existing id' do
      tenant.save
      tenant1 = Tenant.find_or_new(tenant.id)

      tenant1.name.should match 'Tenant 1000'
    end

    it 'should not create tenant and return error when model is invalid' do
      lambda { Tenant.find_or_new(12) }.should raise_error ActiveRecord::RecordNotFound
    end
  end

  context 'can create new tenant and return saved model' do
    it '.create_and_return_model creates and returns saved model' do
      created_tenant = Tenant.create_and_return_model(tenant)
      created_tenant.name.should match 'Tenant 1000'
    end
  end

  it '.create_and_return_model error when tenant model is invalid' do
    tenant.name = '  '
    
    created_tenant = Tenant.create_and_return_model(tenant)
    created_tenant.errors.messages.size.should == 1
  end
end
