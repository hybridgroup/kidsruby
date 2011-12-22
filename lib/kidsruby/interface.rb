require "net/http"
require "uri"

class InterfaceHelper
  def get_interface(location = "/")
    Interface.new(location)
  end
end

def init_interface
  @iface = InterfaceHelper.new.get_interface
end

class Interface
  attr_reader :location

  def initialize(loc)
    @location = loc
  end

  def path
    @location == "/" ? "/" : "#{location}/"
  end

  def call(method, param = nil)
    loc = "http://127.0.0.1:8080#{path}#{method}"
    loc = loc + "?#{URI.escape(param)}" if param
    uri = URI.parse(loc)
    Reply.new(Net::HTTP.get_response(uri))
  end

  def valid?
    true
  end
end

class Reply
  attr_accessor :value, :error_message, :error

  def initialize(r)
    unless r.code == "200"
      @error = true
      @error_message = r.body
    else
      @error = false
      @value = r.body
    end
  end

  def valid?
    @error == false
  end
end
