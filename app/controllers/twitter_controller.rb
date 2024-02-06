# app/controllers/some_controller.rb

class TwitterController < ApplicationController
	before_action :credentials, only: [:create, :logout, :delete]

	def create
		@x_client.post("tweets", '{"text":"' + params[:title] + '"}')
		redirect_to home_path
	end

	def delete
		if params[:tweet_id]
			@x_client.delete("tweets/#{ params[:tweet_id] }") 
			redirect_to home_path
		end
	end

	def logout
		reset_session
		redirect_to root_path
	end

	private
	def credentials
		user = User.find(params[:id])
		x_credentials = {
			api_key:             user.api_key,
			api_key_secret:      user.api_key_secret,
			access_token:        user.access_token,
			access_token_secret: user.access_token_secret,
		}
		@x_client = X::Client.new(**x_credentials)
	end
end
