require "kemal"
require "json"

class BlogData
  JSON.mapping({
    title: String,
    subtitle: String,
    date: String
  })
end

macro define_post_route(filename)
  get "/blog/{{filename}}" do 
    render "src/views/blog/{{filename}}.ecr", "src/views/layouts/blog_layout.ecr"
  end
end

blog_posts = Dir.entries("src/views/blog_post")
puts(blog_posts)
{% for file_path in blog_posts %}
  {% file = file_path.rchop(".ecr") %}
  get "/blog/{{file}}" do 
    render "src/views/blog/{{file_path}}", "src/views/layouts/blog_layout.ecr"
  end 
{% end  %}

get "/" do |env|
  send_file env, "public/homepage.html"
end

get "/blog" do
  #post_files = Dir.entries("src/views/blog_posts")
  posts = Array(BlogData).from_json(File.open("src/blog_post_list.json"))
  #post_json = JSON.parse(File.open("src/blog_post_list.json"))
  #structure: Array of blog post objects {title: String, subtitle: String, Date: String(YYYY-MM-DD), path: String (corresponds to view name)}
  render "src/views/blog_index.ecr", "src/views/layouts/blog_layout.ecr"
end 


Kemal.run