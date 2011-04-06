require "uri"
require "rest_client"

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
    @location = loc
  end

  def path
    @location == "/" ? "/" : "#{location}/"
  end

  def call(method, param = nil)
    loc = "http://localhost:8080#{path}#{method}"
    if param && param.is_a?(String)
      loc = loc + "?#{URI.escape(param)}"
      return Reply.new(RestClient.get(loc))
    elsif param && param.is_a?(Hash)
      return Reply.new(RestClient.post(loc, param['data'], :content_type => 'text/plain'))
    else
      return Reply.new(RestClient.get(loc))
    end
  end

  def valid?
    true
  end  
end

class Reply
  attr_accessor :value, :error_message, :error
  
  def initialize(r)
    unless r.code == 200
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