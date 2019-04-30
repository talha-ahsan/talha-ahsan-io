require "kemal"

get "/" do |env|
  send_file env, "public/homepage.html"
end

get "/blog" do
  post_files = Dir.entries("src/views/blog_posts")
  #parse the file names
  # file format: "Name_in_Snake_Case_Meets_Title_Case___month_day_year.ecr"
  posts = post_files.map{|post_file| 
    args = post_file.split("___")
    return {"post_name": args[0].gsub('_', ' '), 
    "post_date": args[1], 
    "link": ("/blog/" + post_file.gsub("ecr", ""))
    }
  }
  render "src/views/blog_index.ecr", "src/views/layouts/blog_layout.ecr"
end 
Kemal.run