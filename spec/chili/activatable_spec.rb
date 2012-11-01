require 'spec_helper'

module Engine
  extend Chili::Activatable
end

class DummyController
  def logged_in? ; true end
  def admin? ; false end
end

describe Chili::Activatable do
  describe '#active_if & #active?' do
    it "evaluates the active_if block within the context of the instance" do
      Engine.active_if { logged_in? }
      Engine.active?(DummyController.new).should be_true
      Engine.active_if { logged_in? && admin? }
      Engine.active?(DummyController.new).should be_false
    end
  end
end
