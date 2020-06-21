class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
	add_flash_types :success, :info, :warning, :danger # フラッシュメッセージの追加

	# 例外ハンドル
  unless Rails.env.development?
    rescue_from Exception,                        with: :render_500
    rescue_from ActiveRecord::RecordNotFound,     with: :render_404
    rescue_from ActionController::RoutingError,   with: :render_404
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
	end

  protected

	def configure_permitted_parameters
		added_attrs = [ :user_name, :self_introduction, :target, :image]
		devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
		devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	end

	# アカウント登録後、練習日記一覧画面に遷移
	def after_sign_in_path_for(resource)
		practice_diaries_path
	end

	private
  def render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e

    if request.format.to_sym == :json
      render json: { error: '404 error' }, status: :not_found
    else
      render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
    end
  end

  def render_500(e = nil)
    logger.error "Rendering 500 with exception: #{e.message}" if e

    if request.format.to_sym == :json
      render json: { error: '500 error' }, status: :internal_server_error
    else
      render file: Rails.root.join('public/500.html'), status: 500, layout: false, content_type: 'text/html'
    end
  end
end
