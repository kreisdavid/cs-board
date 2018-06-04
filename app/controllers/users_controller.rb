class UsersController < ApplicationController
	def index
	end

	def edit
	end

	# Reverses wants_notifications boolean
	def toggle_get_notifactions
		current_user.update_attribute(:wants_notifications, !current_user.wants_notifications)
		redirect_to users_account_path
	end
end
