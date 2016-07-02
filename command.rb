module Command
  def Command.construct_date
    date = Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S').to_s + " UTC"
    return date
  end

  def Command.construct_get_response(path)
    response_code = ""
    date = "Date: #{construct_date}\r\n"
    file_path = "./#{path}"
    if File.exist?(file_path)
      response_code = "HTTP/1.1 200 OK\r\n"
    else
      response_code = "HTTP/1.1 404 Not Found\r\n"
      file_path = "./404.html"
    end
    server =  "Server: Ruby HTTP server by DevWanderer\r\n"
    content_type = "Content-Type: text/html\r\n"
    file = File.open(file_path,"r")
    content_length = "Content-Length: #{file.size}\r\n"
    response = response_code + date + content_type + content_length +server + "Connection: close\r\n" + "\r\n"

    arr = Array.new
    arr << response
    arr << file

    return arr
  end

  def Command.get(path)
    puts "#{path}, cmd is called"
    path = path +"index.html" if path[-1] =="/"
    return construct_get_response(path)
  end
end
