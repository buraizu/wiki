require 'sinatra'

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

def save_content(title, content)   # => Creates a new file in the pages folder for each title/content pair passed in
  File.open("pages/#{title}.txt", "w") do |file|
    file.print(content)
  end
end

get "/" do    # => Root path
  erb :welcome
end

get "/new" do
  erb :new
end

get "/:title" do
  @title = params[:title]
  @content = page_content(@title)
  erb :show
end
