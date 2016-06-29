module Command
  def construct_date
    date = Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S').to_s + " UTC"
    return date
  end

  def construct_get_response(path)
    system_path = "./#{path}"
  end

  def Command.get(path)
    response = String.new
    puts "#{path}, cmd is called"
    path = path +"index.html" if path[-1] =="/"

  end
end
