module Command
  def Command.construct_date
    date = Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S').to_s + " UTC"
    return date
  end

  def Command.construct_get_response(path)
    response_code = ""
    date = construct_date
    file_path = "./#{path}"
    if File.exist?(file_path)
      response_code = "HTTP/1.1 200 OK"
    else
      response_code = "HTTP/1.1 404 Not Found"
      file_path = "./404.html"
    end

    file = File.open(file_path,"r")
    response = %{
      #{response_code}
      Date: #{date}
      Server: Ruby HTTP server by DevWanderer
    }

    file.each do |line|
      response += line
    end
    return response
  end

  def Command.get(path)
    puts "#{path}, cmd is called"
    path = path +"index.html" if path[-1] =="/"
    return construct_get_response(path)
  end
end
