class ApplicationController < ActionController::API
  rescue_from ActionDispatch::Http::Parameters::ParseError do |exception|
    render json: { errors: [exception.message] }, status: :bad_request
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { errors: exception }, status: :bad_request
  end
end
