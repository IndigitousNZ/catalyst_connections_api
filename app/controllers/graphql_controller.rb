class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!

  def execute
    render json: load_result
  end

  private

  def load_result
    CatalystConnectionsApiSchema.execute(
      query,
      context: context,
      operation_name: operation_name,
      variables: variables
    )
  end

  def query
    params[:query]
  end

  def context
    {
      # Query context goes here, for example:
      current_user: current_user
    }
  end

  def operation_name
    params[:operationName]
  end

  # Handle form data, JSON body, or a blank value
  def variables
    ambiguous_param = params[:variables] || {}
    case ambiguous_param
    when String
      ambiguous_param.present? ? ensure_hash(JSON.parse(ambiguous_param)) : {}
    when Hash, ActionController::Parameters
      ambiguous_param
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def current_user
    @current_user ||= User.find(doorkeeper_token[:resource_owner_id])
  end
end
