require_relative '../phase3/controller_base'
require_relative './session'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      super
      session.store_session(res)
    end

    def render_content(content, content_type)
      super
      session.store_session(res)
    end

    def session
      @session ||= Session.new(req)
    end
  end
end
