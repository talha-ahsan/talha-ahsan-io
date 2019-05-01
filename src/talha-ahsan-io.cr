require "kemal"
require "json"

get "/" do |env|
  send_file env, "public/homepage.html"
end

get "/blog" do
  #post_files = Dir.entries("src/views/blog_posts")
  post_json = JSON.parse(File.open("src/blog_posts.json"))
  #structure: Array of blog post objects {title: String, subtitle: String, Date: String(YYYY-MM-DD), path: String (corresponds to view name)}
  render "src/views/blog_index.ecr", "src/views/layouts/blog_layout.ecr"
end 
Kemal.run