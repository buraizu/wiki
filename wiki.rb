require 'sinatra'

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

get "/" do    # => Root path
  erb :welcome
end

get "/test" do
  erb :test
end

get "/:title" do
  page_content(params[:title])
end
