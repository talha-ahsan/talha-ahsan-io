require "kemal"

get "/" do |env|
  send_file env, "src/views/homepage.html"
end

Kemal.run