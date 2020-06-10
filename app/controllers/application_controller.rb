class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
	add_flash_types :success, :info, :warning, :danger # フラッシュメッセージの追加

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
end
