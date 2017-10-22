Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :me do
    type Types::UserType
    description 'current user'
    resolve ->(_obj, _args, ctx) { ctx[:current_user] }
  end

  connection :points, Types::PointType.connection_type do
    argument :distance, types.Float
    resolve ->(_obj, args, ctx) { Point.nearby(ctx[:current_user], args[:distance] || 400) }
  end

  field :node, GraphQL::Relay::Node.field
  field :nodes, GraphQL::Relay::Node.plural_field
end
