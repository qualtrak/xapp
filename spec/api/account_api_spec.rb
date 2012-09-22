require 'spec_helper'

describe AccountApi do
  context 'GET /api/accounts/:id' do
    it 'should get empty account for id 0' do
      account = Account.new

      get '/api/accounts/0'
      response.status.should == 200
      JSON.parse(response.body)['id'].should be_nil
    end

    it 'should get existing account for id 1' do
      create(:account)
      get '/api/accounts/1'
      response.status.should == 200
      account = JSON.parse(response.body)
      JSON.parse(response.body)['id'].should == 1
    end
  end

  context 'POST /api/accounts/:id' do
    let :new_account do
      { account: { name: 'bla', email: 'bla@bla.com' } }
    end

    it 'should create new and retun saved account' do
      post '/api/accounts', new_account.as_json
      response.status.should == 201
      JSON.parse(response.body)['name'].should match 'bla'
    end

    it 'should not create account but return error when model is invalid' do
      new_account[:account][:name] = ''
      post '/api/accounts', new_account.as_json

      response.status.should == 404
      JSON.parse(response.body).size == 1
    end
  end
end


