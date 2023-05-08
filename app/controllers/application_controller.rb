class ApplicationController < ActionController::API
    def not_found
        render json: {error: 'not_found'}
    end


    def authorize_request
        puts "Authorizing Strict"
        begin
          get_user_from_headers(request.headers)
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: "Missing Authentication Token" }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: "Invalid Authentication Token" }, status: :unauthorized
        end
    end

    def authorize_request_conditionally
      begin
        get_user_from_headers(request.headers)
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
        @current_user = nil
      end
    end


    private

      def get_user_from_headers(headers)
        header = headers['Authorization']
        header = header.split(' ').last if header

        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      end
end
