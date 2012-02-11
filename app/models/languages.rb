module KidsRuby
  LANGUAGES_SUPPORTED = %w{en}

  class << self
    def system_language
      Qt::Locale.system.name[0..1]
    end

    def default_language
      'en'
    end

    def languages_supported
      LANGUAGES_SUPPORTED
    end

    def language
      if languages_supported.include?(system_language)
        system_language
      else
        default_language
      end
    end
  end
end

