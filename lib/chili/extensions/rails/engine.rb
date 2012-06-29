class Rails::Engine
  def self.automount!(path = nil)
    engine = self
    path ||= 'chili/' + engine.parent.to_s.underscore
    Rails.application.routes.draw do
      mount engine => path
    end
  end
end
