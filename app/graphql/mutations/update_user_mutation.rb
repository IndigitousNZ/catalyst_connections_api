Mutations::UpdateUserMutation = GraphQL::Relay::Mutation.define do
  # Used to name derived types, eg `"AddCommentInput"`:
  name 'UpdateUser'
  description 'Update a user and return user'

  # Accessible from `inputs` in the resolve function:
  input_field :first_name, !types.String
  input_field :last_name, !types.String

  # The result has access to these fields,
  # resolve must return a hash with these keys.
  # On the client-side this would be configured
  # as RANGE_ADD mutation, so our returned fields
  # must conform to that API.
  return_field :user, Types::UserType

  # The resolve proc is where you alter the system state.
  resolve(lambda do |_object, inputs, ctx|
    current_user = ctx[:current_user]
    current_user.update(
      first_name: inputs[:first_name],
      last_name: inputs[:last_name]
    )

    { user: current_user }
  end)
end
