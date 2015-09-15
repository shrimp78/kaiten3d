class TopController < ApplicationController
  def index
  end

  def upload
    file = params[:img]
    name = file[:datafile].original_filename
    @file_path = "/img/#{name}"
    File.open("public#{@file_path}", 'wb') { |f|
      f.write(file[:datafile].read)
    }

    render 'index'
  end
end
