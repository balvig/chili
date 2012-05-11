class Rails::Engine
  def self.automount!(path = nil)
    engine = self
    path ||= engine.to_s.underscore.split('/').first
    Rails.application.routes.draw do
      mount engine => path
    end
  end
end
