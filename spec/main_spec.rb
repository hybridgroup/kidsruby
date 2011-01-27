require_relative "spec_helper"
require_relative "../app/widgets/main.rb"

#require File.dirname(__FILE__) + '/../main'

describe "main" do
  describe "when opening the main app" do
    before do
      @app = Qt::Application.new(ARGV)
    end
    
    it "must instanciate an app" do
      @app.wont_be_nil
    end
    
    # after do
    #   @app.dispose!
    # end
  end
end