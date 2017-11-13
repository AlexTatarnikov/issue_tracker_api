module ActionController
  class Responder
    protected

    # This is the common behavior for formats associated with APIs, such as :xml and :json.
    def api_behavior
      raise MissingRenderer.new(format) unless has_renderer?

      if get?
        display resource
      elsif post?
        display resource, :status => :created
      elsif put?
        display resource
      else
        head :no_content
      end
    end
  end
end
