require "kemal"
require "json"

class BlogData
  JSON.mapping({
    title: String,
    subtitle: String,
    date: String,
    path: String
  })
end

get "/" do |env|
  send_file env, "public/homepage.html"
end

get "/blog" do
  posts = Array(BlogData).from_json(File.open("src/blog_post_list.json"))
  render "src/views/blog_index.ecr", "src/views/layouts/blog_layout.ecr"
end 

{% for file_path in system("ls src/views/blog").split %}
  {% if file_path.includes?(".ecr") %}
    {% file = file_path[0...-4] %}
    get "/blog/{{file.id}}" do 
      render "src/views/blog/{{file_path.id}}", "src/views/layouts/blog_layout.ecr"
    end 
  {% end %}
{% end  %}

Kemal.run