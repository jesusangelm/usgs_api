class Api::CommentsController < ApplicationController
  before_action :find_feature, only: :create

  def create
    @comment = @feature.comments.build(comment_params)

    if @comment.save
      render json: { success: 'comment created' }
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_feature
    @feature = Feature.find_by_id(params[:feature_id])
    return unless @feature.blank?

    render json: { error: 'feature not found' },
           status: :not_found and return
  end
end
