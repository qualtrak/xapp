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

  context 'can find by id or add new for id 0' do
    it '.find_or_new should instantiate new Account when id is 0' do
      new_account = Account.find_or_new(0)
      new_account.active.should be_true
    end

    it '.find_or_new id argument must be integer' do
      lambda { Account.find_or_new('x') }.should raise_error TypeError, 'The id must be an integer!'
    end

    it '.find_or_new should find existing id' do
      account.save
      account1 = Account.find_or_new(1)

      account1.name.should match 'NoName'
    end

    it '.find_or_new raise when fetching non-existing id' do
      lambda { Account.find_or_new(12) }.should raise_error ActiveRecord::RecordNotFound
    end
  end

  context 'can create new account and saved return model' do
    let :new_account do
      Account.new(name: 'bla', email: 'info@example.com')
    end

    subject do
      new_account
    end

    it '.create_and_retun_model creates and return turn savod model' do
      created_account = Account.create_and_return_model(new_account)
      created_account.name.should match /bla/
    end

    it '.create_and_return_model error when' do
      new_account.name = nil

      created_account = Account.create_and_return_model(new_account)
      created_account.errors.messages.should_not be_nil
    end
  end
end
