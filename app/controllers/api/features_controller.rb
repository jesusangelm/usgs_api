class Api::FeaturesController < ApplicationController
  include Pagy::Backend
  before_action :prepare_per_page, only: :index
  before_action :allowed_mag_type, only: :index, if: -> { params[:mag_type].presence }
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    if params[:per_page] > 1000
      render json: { error: 'per_page param must not be greather than 1000' }
    else
      features = params[:mag_type].presence ? Feature.by_mag_type(params[:mag_type]) : Feature.all

      @pagy, @features = pagy(features, items: params[:per_page])

      render json: { data: @features, pagination: @pagy }
    end
  end

  private

  def prepare_per_page
    params[:per_page] = params[:per_page].presence ? params[:per_page].to_i : Pagy::DEFAULT[:items]
  end

  def allowed_mag_type
    mag_types = %w[md ml ms mw me mi mb mlg]
    return if params[:mag_type].presence && (params[:mag_type] - mag_types).empty?

    render json: { error: "mag_type must contain some of following: #{mag_types.join(', ')}" }
  end
end
