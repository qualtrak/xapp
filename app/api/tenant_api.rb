class TenantApi < Grape::API
  resource :tenants do
    get '/' do
      Tenant.all.to_json(only: [:id, :name, :description, :active])
    end

    get '/:id' do
      Tenant.find_or_new(params[:id].to_i).to_json
    end

    post '/' do
      new_tenant = Tenant.new(params[:tenant])
      created_tenant = Tenant.create_and_return_model(new_tenant)

      if created_tenant.errors.messages.size > 0
        status 404
        created_tenant.errors.full_messages.to_json
      else
        created_tenant.to_json
      end
    end

    put '/:id' do
      tenant = Tenant.find(params[:id])
      if tenant.update_attributes(params[:tenant])
        tenant.to_json
      else
        status 404
        tenant.errors.full_messages.to_json
      end
    end

    delete '/:id' do
      begin
        tenant = Tenant.find(params[:id])
        
        tenant.destroy

        if tenant.destroyed?
          status 204
        end
      rescue 
        status 404
      end
    end
  end
end
