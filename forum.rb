require 'sinatra'
require 'pg'
require 'pry'
require "./models/message.rb"
require "./models/comment.rb"

get '/messages' do
  @items = Message.all
  erb :index, layout: :items
end

get "/message/:id" do
  id = params[:id]
  @items = Comment.get_all_like(id)
  @ms = Message.get(id)
  erb :message, layout: :items
end

post "/messages" do
  Message.new(params)
  redirect to("/messages")
end

post "/message" do
  id = params[:ms]
  Comment.new(params)
  redirect to("/message/#{id}")
end

get "/comment/:mes_id/:com_id/delete" do
  Comment.delete(params[:com_id])
  redirect to("/message/#{params[:mes_id]}")
end

get "/message/:id/delete" do
  Message.delete(params[:id])
  redirect to("/messages")
end