require 'uri'

# http server listening on port 8080 to do the inter-process communication
class KidsRubyServer < Qt::TcpServer
  slots 'connection()'

  # Initialize the server and put into listen mode (port is 8080)
  def initialize(parent = nil)
    super
    @parent = parent
    
    listen(Qt::HostAddress.new(Qt::HostAddress::LocalHost), 8080)
    connect(self, SIGNAL('newConnection()'), SLOT('connection()'));
  end

  # Signals an incoming connection
  def connection
    begin
      connection = nextPendingConnection
      url = nil
      while connection.isOpen
        if connection.canReadLine
          line = connection.readLine.to_s
          if line.chomp == "" 
            break
          elsif line =~ /GET\s+(.*)\s+HTTP/
            url = Qt::Url.new($1)
          end
        else
          connection.waitForReadyRead(100)
        end
      end

      if url && url.path =~ /\/turtle\/(.*)/
        # todo: hook up the tutule with new protocol
        connection.write("Calling turtle with command #{$1} with params #{url.encodedQuery}")
      elsif url && url.path =~ /\/(.*)/
        command = $1
        param = URI.decode(url.encodedQuery.to_s)
        if command == "alert"
          @parent.alert(param)
          connection.write validResponse("OK")
        elsif command == "ask"
          connection.write validResponse(@parent.ask(param))          
        elsif command == "append"
          @parent.append(param)
          connection.write validResponse("OK")
        elsif command == "appendError"
          @parent.appendError(param)
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