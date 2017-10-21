Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  post '/graphql', to: 'graphql#execute'
  use_doorkeeper do
    # it accepts :authorizations, :tokens, :applications and :authorized_applications
    skip_controllers :applications, :authorized_applications
  end
end
