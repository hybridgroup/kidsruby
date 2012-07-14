module KidsRuby
  class Language
    LANGUAGES_SUPPORTED = %w{en es ja fr}

    class << self
      def system
        Qt::Locale.system.name[0..1]
      end

      def default
        'en'
      end

      def supported
        LANGUAGES_SUPPORTED
      end

      def current
        if supported.include?(system)
          system
        else
          default
        end
      end
    end
  end
end

