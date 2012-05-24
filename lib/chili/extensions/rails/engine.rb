class Rails::Engine
  def self.automount!(path = nil)
    engine = self
    path ||= engine.parent.to_s.underscore.sub('_','/')
    Rails.application.routes.draw do
      mount engine => path
    end
  end
end
