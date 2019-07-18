require 'sinatra/base'
require './app/models/Bookmark.rb'

class ApplicationManager < Sinatra::Base

  configure do
    enable :session, :method_override
    set :views, "app/views"
    set :public_dir, "public"
  end

  get '/'  do
    erb(:index)
  end

  get '/bookmarks' do
    @bookmark_list = Bookmark.list
    erb(:bookmarks)
  end

  get '/create-bookmarks' do
    erb (:create_bookmarks)
  end

  post '/bookmarks-added' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb (:update_bookmarks)

  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect ('/bookmarks')
  end

  run! if app_file == $0

end
#hi
