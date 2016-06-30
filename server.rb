require 'socket'
require_relative 'command'

class WebServer

  def parse_request(request)
    @command = request[0].split[0]
    @path = request[0].split[1]
    request = request.drop(1)
    @parameters = Hash.new

    request.each do |line|
      @parameters[line.split[0].to_s] = line.split[1..-1].join
    end


  end

  def command_handle (command)
    case command
    when 'GET' then return Command.get(@path)

    else
      puts "Sorry, unknown command: #{command}"

    end
  end

  def run
    server = TCPServer.new(8080)

    request = Array.new

    while connection = server.accept
      while line = connection.gets
        request << line
        break if line.split[0] == "Connection:"
      end
      parse_request(request)

      connection.puts command_handle(@command)[0]
      IO.copy_stream command_handle(@command)[1],connection
      request.clear
      connection.close
    end

  end

end

a = WebServer.new
a.run
