require 'sinatra'
require 'uri'

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

get "/:title/edit" do
  @title = params[:title]
  @content = page_content(@title)
  erb :edit
end

post "/create" do
  save_content(params[:title], params[:content])
  redirect URI.escape("/#{params[:title]}")     # => URI.escape removes spaces from title.
end
