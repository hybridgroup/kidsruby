require_relative "../spec_helper"
require_relative "../../app/models/languages"

describe 'KidsRubyLanguages' do
  it "should default to 'en'" do
    KidsRuby::Language.default.must_equal 'en'
  end

  it "should not allow unsupported language" do
    KidsRuby::Language.stubs(:system).returns('av')
    KidsRuby::Language.current.wont_equal 'av'
    KidsRuby::Language.current.must_equal 'en'
  end

  it "should allow any supported language" do
    KidsRuby::Language.stubs(:system).returns('es')
    KidsRuby::Language.stubs(:supported).returns(['es', 'en', 'ru'])
    KidsRuby::Language.current.must_equal 'es'
  end
end
