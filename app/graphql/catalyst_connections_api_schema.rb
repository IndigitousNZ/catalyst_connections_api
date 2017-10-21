CatalystConnectionsApiSchema = GraphQL::Schema.define do
  query(Types::QueryType)
  mutation(Types::MutationType)

  # Relay Object Identification:

  # Return a string UUID for `object`
  id_from_object(lambda do |object, _type_definition, _query_ctx|
    GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
  end)

  # Given a string UUID, find the object
  object_from_id(lambda do |_id, _ctx|
    klass, object_id = GraphQL::Schema::UniqueWithinType.decode(id)
    Object.const_get(klass).find(object_id)
  end)

  # Object Resolution
  resolve_type(lambda do |obj, _ctx|
    case obj
    when User
      Types::UserType
    else
      raise("Unexpected object: #{obj}")
    end
  end)
end
