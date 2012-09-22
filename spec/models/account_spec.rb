require 'spec_helper'

describe Account do
  let :account do
    build(:account)
  end

  subject do
    account
  end

  it 'is #active by default' do
    account.active.should be_true
  end

  it 'is valid' do
    should be_valid
  end

  context 'is invalid' do
    it 'when #name is not given' do
      account.name = ''
      should_not be_valid
    end

    it 'when #email is not given' do
      account.email = ''
      should_not be_valid
    end
  end

  context 'can find by id or add new for id is 0' do
    it '.find_or_new id argument must be integer' do
      lambda { Account.find_or_new('x') }.should raise_error TypeError, 'The id must be an integer!'
    end
    
    it '.find_or_new should instantiate new Account when id is 0' do
      new_account = Account.find_or_new(0)
      new_account.should be_active
    end

    it '.find_or_new should find existing id' do
      account.save
      account1 = Account.find_or_new(account.id)

      account1.name.should match 'NoName'
    end

    it '.find_or_new raise when fetching non-existing id' do
      lambda { Account.find_or_new(12) }.should raise_error ActiveRecord::RecordNotFound
    end
  end

  context 'can create new account and return saved model' do
    it '.create_and_retun_model creates and returns turn saved model' do
      created_account = Account.create_and_return_model(account)
      created_account.name.should match 'NoName Ltd.'
    end

    it '.create_and_return_model error when account model is invalid' do
      account.name = nil

      created_account = Account.create_and_return_model(account)
      created_account.errors.messages.size.should == 1
    end
  end
end
