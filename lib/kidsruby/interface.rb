require "net/http"
require "uri"

class InterfaceHelper
  def connect!
    # now stateless, no need to connect in advance
  end
  
  def get_interface(location = "/")
    Interface.new(location)
  end

  def get_reply(message)
    # get rid of this, reply will be returned directly from Interface call
    message
  end
end

class Interface
  attr_reader :location

  def initialize(loc)
    location = loc
  end

  def path
    location == "/" ? "/" : "#{location}/"
  end

  def call(method, param = nil)
    loc = "http://localhost:8080#{path}#{method}"
    loc = loc + "?#{URI.escape(param)}" if param
    uri = URI.parse(loc)
    response = Net::HTTP.get_response(uri)

    reply = Reply.new
    reply.value = response.body
    reply
  end

  def valid?
    true
  end  
end

class Reply
  attr_accessor :value, :error_message

  def valid?
    true
  end
end