class TopController < ApplicationController
  def index
  end

  def upload
    if file = params[:img]
      file = file[:datafile]
      name = file.original_filename
      ext_name = File.extname(name)
      unless ext_name =~ /[jpeg|jpg|png]/
        @msg = "なんやねん、そのファイル"
        render 'error' and return
      end
      @file_path = "/img/#{name}"
      @full_path = "public#{@file_path}"
      @msg = "はい、できました"
    else
      @msg = "画像ファイルきてないで"
      render 'error' and return
    end

    # 保存のタイミング
    File.open(@full_path, 'wb') { |f| f.write(file.read) }

    # 画像変換 
    convertImage(@full_path)

    render 'index'
  end

  private
  def convertImage file_path
    img = Magick::ImageList.new(file_path)
    width = img.columns
    height = img.rows
    length = (height * 2) + width
    sheet = Magick::Image.new(length, length){self.background_color = "white"}
    
    # A 
    result = sheet.composite(img, height, 0, Magick::OverCompositeOp)

    # B
    img = img.rotate(90)
    result = result.composite(img, height + width, height, Magick::OverCompositeOp)

    # C
    img = img.rotate(90)
    result = result.composite(img, height, height + width, Magick::OverCompositeOp)

    # D
    img = img.rotate(90)
    result = result.composite(img, 0, height, Magick::OverCompositeOp)

    result.write(file_path)
  end
end
