module BackUrlMemorizer
  extend ActiveSupport::Concern

  METHOD_GET = 'GET'.freeze

  included do
    def set_back_url
      @referer = request.referer
      return @back_url = cookies[:referer] unless back_url_valid?

      cookies[:referer] = @referer
      @back_url = @referer
    end

    private

    def back_url_valid?
      [back_path_present?, current_method_get?, page_was_not_refreshed?].all?
    end

    def back_path_present?
      @referer
    end

    def current_method_get?
      request.method.eql?(METHOD_GET)
    end

    def page_was_not_refreshed?
      @referer != request.url
    end
  end
end
