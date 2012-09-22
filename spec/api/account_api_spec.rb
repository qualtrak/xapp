require 'spec_helper'

describe AccountApi do
  context 'GET /api/accounts/:id' do
    it 'should get empty account for id 0' do
      account = Account.new

      get '/api/accounts/0'
      response.status.should == 200
      response.body.should match /true/
    end

    it 'should get existing account for id 1' do
      create(:account)
      get '/api/accounts/1'
      response.status.should == 200
      response.body.should match /1/
    end
  end

  context 'POST /api/accounts/:id' do
    let :new_account do
      { account: { name: 'bla', email: 'bla@bla.com' } }
    end

    it 'should create new and retun saved account' do
      post '/api/accounts', new_account.as_json
      response.status.should == 201
      response.body.should match /bla/
    end

    it 'should not create account and return error when model is invalid' do
      new_account[:account][:name] = ''
      post '/api/accounts', new_account.as_json, 'Content-Type' => 'application/json'

      response.status.should == 404
    end
  end
end


