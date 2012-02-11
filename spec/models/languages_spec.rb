require_relative "../spec_helper"
require_relative "../../app/models/languages"

describe 'KidsRubyLanguages' do
  it "should default to 'en'" do
    KidsRuby.default_language.must_equal 'en'
  end

  it "should not allow unsupported language" do
    KidsRuby.stubs(:system_language).returns('av')
    KidsRuby.language.wont_equal 'av'
    KidsRuby.language.must_equal 'en'
  end

  it "should allow any supported language" do
    KidsRuby.stubs(:system_language).returns('es')
    KidsRuby.stubs(:languages_supported).returns(['es', 'en', 'ru'])
    KidsRuby.language.must_equal 'es'
  end
end
