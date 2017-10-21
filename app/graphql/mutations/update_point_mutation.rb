Mutations::UpdatePointMutation = GraphQL::Relay::Mutation.define do
  # Used to name derived types, eg `"AddCommentInput"`:
  name 'UpdatePoint'
  description 'Update a user point and return point'

  # Accessible from `inputs` in the resolve function:
  input_field :address_line_1, types.String
  input_field :address_line_2, types.String
  input_field :suburb, types.String
  input_field :city, types.String
  input_field :country, types.String
  input_field :zip, types.String
  input_field :latitude, !types.Float
  input_field :longitude, !types.Float

  # The result has access to these fields,
  # resolve must return a hash with these keys.
  # On the client-side this would be configured
  # as RANGE_ADD mutation, so our returned fields
  # must conform to that API.
  return_field :point, Types::PointType

  # The resolve proc is where you alter the system state.
  resolve(lambda do |_object, inputs, ctx|
    point = ctx[:current_user].point || ctx[:current_user].build_point
    point.update(
      address_line_1: inputs[:address_line_1],
      address_line_2: inputs[:address_line_2],
      suburb: inputs[:suburb],
      city: inputs[:city],
      country: inputs[:country],
      zip: inputs[:zip],
      latitude: inputs[:latitude],
      longitude: inputs[:longitude]
    )

    { point: point }
  end)
end
