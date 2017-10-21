Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :updatePointMutation, field: Mutations::UpdatePointMutation.field
  field :updateUserMutatation, field: Mutations::UpdateUserMutation.field
end
