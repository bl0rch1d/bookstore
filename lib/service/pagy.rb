module Service
  class Pagy
    class << self
      include ::Pagy::Backend

      def call(collection, page:, **options)
        @params = { page: page }
        pagy(collection, options)
      end

      private

      attr_reader :params
    end
  end
end
