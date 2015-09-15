class TopController < ApplicationController
  def index
  end

  def upload
    file = params[:img][:datafile]
    name = file.original_filename
    @file_path = "/img/#{name}"
    File.open("public#{@file_path}", 'wb') { |f|
      f.write(file.read)
    }

    render 'index'
  end
end
