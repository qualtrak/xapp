require 'spec_helper'

describe TenantApi do
  it 'GET /api/tenants returns list of tenants' do
    create(:tenant)
    create(:tenant1)

    get '/api/tenants'
    response.status.should == 200
    JSON.parse(response.body).size == 2
  end

  context 'GET /api/tenants/:id' do
    it 'should get empty tenant for id 0' do
      tenant = Tenant.new

      get '/api/tenants/0'
      response.status.should == 200
      JSON.parse(response.body)['id'].should be_nil
    end

    it 'should get existing tenant for id ' do
      create(:tenant)

      get '/api/tenants/1'
      response.status.should == 200
      JSON.parse(response.body)['id'].should == 1
    end
  end

  context 'POST /api/tenants' do
    let :new_tenant do
      account = create(:account)
      { tenant: { name: 'Tenant 1000', account_id: account.id } }
    end

    it 'should create new and retun saved tenant' do
      post '/api/tenants', new_tenant.as_json
      response.status.should == 201
      JSON.parse(response.body)['name'].should match 'Tenant 1000'
    end

    it 'should not create tenant but retunt error when tenant model is invalid' do
      new_tenant[:tenant][:name] = nil

      post '/api/tenants', new_tenant
      response.status.should == 404
      JSON.parse(response.body).size == 1
    end
  end
end
