class AccountApi < Grape::API
  resource :accounts do
    get '/:id' do
      account = Account.find_or_new(params[:id].to_i)
      account.to_json(except: [:created_at, :updated_at])
    end

    post '/' do
      new_account = Account.new(params[:account])
      created_account = Account.create_and_return_model(new_account)

      if created_account.errors.messages.size > 0
        status 404
        created_account.errors.full_messages.to_json
      else
        created_account.to_json
      end
    end
  end
end
