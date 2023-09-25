# frozen_string_literal: true

class ApplicationController < ActionController::API
  #  handling exceptions for invalid record, non existing route and missing parameter
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActionController::RoutingError, with: :routing_error
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def record_invalid(exception)
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def routing_error
    render json: { error: "Routing error: #{exception.message}" }, status: :not_found
  end

  def parameter_missing
    render json: { error: "Parameter missing: #{exception.message}" }, status: :bad_request
  end
end
