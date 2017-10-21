Unions::PointResourceUnion = GraphQL::UnionType.define do
  name 'PointResource'
  description 'User object'
  possible_types [Types::UserType]
end
