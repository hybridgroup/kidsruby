require 'uri'
require 'json/pure'

# http server listening on port 8080 to do the inter-process communication
class KidsRubyServer < Qt::TcpServer
  slots 'connection()'

  # Initialize the server and put into listen mode (port is 8080)
  def initialize(parent = nil, turtle = nil)
    super(parent)
    @parent = parent
    @turtle = turtle
    
    listen(Qt::HostAddress.new(Qt::HostAddress::LocalHost), 8080)
    connect(self, SIGNAL('newConnection()'), SLOT('connection()'));
  end

  # Signals an incoming connection
  def connection
    begin
      connection = nextPendingConnection
      url = nil
      body = ""
      headers = ""
      while connection.isOpen
        if connection.canReadLine
          line = connection.readLine.to_s
          if line =~ /(GET|POST)\s+(.*)\s+HTTP/
            url = Qt::Url.new($2)
            break
          else
            break # some kind of error?
          end
        else
          connection.waitForReadyRead(100)
        end
      end
      
      while connection.isOpen
        if connection.canReadLine
          line = connection.readLine.to_s
          if line.chomp == ""
            break
          else
            headers << line
          end
        else
          connection.waitForReadyRead(100)
        end
      end
            
      if connection.isOpen
        body = connection.readAll.to_s
      end
      
      if url && url.path =~ /\/turtle\/(.*)/
        command = $1
        param = URI.decode(url.encodedQuery.to_s)
        if command == "init_turtle"
          @turtle.init_turtle
          connection.write validResponse("OK")
        elsif command == "command_turtle"
          @turtle.command_turtle(param)
          connection.write validResponse("OK")
        elsif command == "background"
          @turtle.background(param)
          connection.write validResponse("OK")
        elsif command == "width"
          connection.write validResponse(@turtle.width)
        elsif command == "height"
          connection.write validResponse(@turtle.height)
        else
          connection.write errorResponse
        end
      elsif url && url.path =~ /\/(.*)/
        command = $1
        if command == "alert"
          param = URI.decode(url.encodedQuery.to_s)
          @parent.alert(param)
          connection.write validResponse("OK")
        elsif command == "ask"
          param = URI.decode(url.encodedQuery.to_s)
          connection.write validResponse(@parent.ask(param))          
        elsif command == "append"
          param = URI.decode(url.encodedQuery.to_s)          
          @parent.append(param)
          connection.write validResponse("OK")
        elsif command == "appendError"
          body.each_line {|l| @parent.appendError( JSON.parse(l)['error'] )}
          #@parent.appendError(body)
          connection.write validResponse("OK")
        elsif command == "gets"
          connection.write validResponse(@parent.gets)          
        else
          connection.write errorResponse
        end
      else
        connection.write errorResponse
      end

      connection.disconnectFromHost()
    rescue 
      puts "ERROR #{$!}"
    end
  end
  
  def errorResponse
    "HTTP/1.0 400 Bad Request\r\n"
  end
  
  def validResponse(data)
	  "HTTP/1.0 200 Ok\r\n" +
      "Content-Type: text/plain; charset=\"utf-8\"\r\n" +
      "\r\n" +
      "#{data}"
	end
	
	def handleError(err)
	  #todo: display something here
	end
end