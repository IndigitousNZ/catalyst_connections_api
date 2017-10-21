Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A user'
  implements GraphQL::Relay::Node.interface
  global_id_field :id
  field :first_name, types.String
  field :last_name, types.String
  field :avatar_url, !types.String
  field :facebook_url, !types.String
  field :point, Types::PointType
  field :updated_at do
    type types.Int
    resolve ->(obj, _args, _ctx) { obj.updated_at.to_i }
  end
  field :created_at do
    type types.Int
    resolve ->(obj, _args, _ctx) { obj.created_at.to_i }
  end
end
