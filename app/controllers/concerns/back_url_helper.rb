module BackUrlHelper
  extend ActiveSupport::Concern

  included do
    def set_back_url
      cookies[:referer] = request.referer if request.referer

      @back_url = cookies[:referer] || root_path
    end
  end
end
