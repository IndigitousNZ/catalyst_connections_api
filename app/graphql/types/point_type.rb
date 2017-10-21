Types::PointType = GraphQL::ObjectType.define do
  name 'Point'
  description 'A point of interest'
  implements GraphQL::Relay::Node.interface
  global_id_field :id
  field :address_line_1, types.String
  field :address_line_2, types.String
  field :suburb, types.String
  field :city, types.String
  field :country, types.String
  field :zip, types.String
  field :latitude, !types.Float
  field :longitude, !types.Float
  field :resource, !Unions::PointResourceUnion
  field :updated_at do
    type types.Int
    resolve ->(obj, _args, _ctx) { obj.updated_at.to_i }
  end
  field :created_at do
    type types.Int
    resolve ->(obj, _args, _ctx) { obj.created_at.to_i }
  end
end
