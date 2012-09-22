App::Application.routes.draw do
  mount AccountApi => '/api'
  mount TenantApi => 'api'
end
