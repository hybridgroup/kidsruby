module InvertsTheme
  def self.included(kls)
    kls.extend(Config)
  end
  module Config
    def default_theme(theme=nil)
      theme ? @default_theme = theme : @default_theme
    end
    def alternate_theme(theme=nil)
      theme ? @alternate_theme = theme : @alternate_theme
    end
  end

  attr_accessor :current_theme
  def current_theme
    @current_theme ||= self.class.default_theme
  end

  def keyPressEvent(event)
    invert_key = (event.key == Qt::Key_I && event.modifiers == Qt::CTRL)
    invert_key ? invert_theme : super
  end

  protected

  def invert_theme
    self.current_theme = using_default_theme? ? alternate_theme : default_theme
    set_theme(self.current_theme)
  rescue NoMethodError
    fail 'implement "set_theme(theme)" method.'
  end

  private

  def using_default_theme?
    current_theme == default_theme
  end

  def alternate_theme
    self.class.alternate_theme
  end

  def default_theme
    self.class.default_theme
  end
end
