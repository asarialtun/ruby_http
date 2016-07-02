require 'socket'
class Browser
  @method = String.new

  def choose_method
    puts "Please choose method\n(1)GET\n(2)POST\nEnter number:"
    selection = gets.chomp
    return selection
  end

  def get_method(target_path, target_host)
    get_string = "GET #{target_path} HTTP/1.1\r\nHost: #{target_host}\r\nUser-Agent: CLIBrowser by DevWanderer\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nConnection: keep-alive\r\n\r\n"

  end

  def parse_get
    puts "Enter the url and port, e.g localhost:8080/"
    url = gets.chomp

    if url.split(":")[1]
      port = url.split(":")[1].match(/\d+/)[0].to_i
    else
      port = 80
    end
    host = url.split("/")[0]
    host = url.split(":")[0] if url.include?(":")

    path = url.split("/")[1..-1].join("/")
    path += "/" if url[-1]== ("/")
    path = "/" if path == ""
    result = Hash.new
    result["host"] = host
    result["path"] = path
    result["port"] = port unless port == 80
    return result
  end

  def post_method
  end



  def run
    selection = choose_method
    @method = "GET" if selection == "1"
    @method = "POST" if selection == "2"
    if @method == "GET"
      parsed_hash = parse_get
      parsed_hash["host"] += ":#{parsed_hash["port"]}" if parsed_hash["port"] != nil
      get_string = get_method(parsed_hash["path"],parsed_hash["host"])
      #I have to send this get_string to the http server through socket
      hostname = parsed_hash["host"].split(":")[0]
      port = parsed_hash["port"].to_i
      port = 80 if port == 0
      socket = TCPSocket.open(hostname,port)
      socket.print(get_string)
    #  socket.print(get_string)
      response = socket.read
      socket.close
      puts response.split("\r\n\r\n")[1]


    end

  end

end

aa = Browser.new
aa.run
