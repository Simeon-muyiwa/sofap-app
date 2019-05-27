class ApplicationController < ActionController::API

	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	def record_not_found(exception) 
      full_message_error "cannot find id[#{params[:id]}]", :not_found
      Rails.logger.debug exception.message
    end

    def full_message_error full_message, status
      payload = {
        errors: { full_messages:["#{full_message}"] }
      }
      render :json=>payload, :status=>status
    end
end
