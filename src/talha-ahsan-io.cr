require "kemal"

get "/" do |env|
  send_file env, "public/homepage.html"
end

Kemal.run