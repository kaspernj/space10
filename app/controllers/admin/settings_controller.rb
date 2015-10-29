class Admin::SettingsController < AdminController
	def edit
		@settings = Settings.get
	end

	def update
		Settings.update(params['settings'])
		redirect_to admin_edit_settings_path
	end
end
