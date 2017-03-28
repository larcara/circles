require_relative "./circle.rb"
require 'sinatra'
require 'haml'
require "rubygems"
require 'RMagick'

post  '/' do
  x_size = params[:custom_size][0].to_f.send(:cm)
  y_size = params[:custom_size][1].to_f.send(:cm)
  custom_size = [x_size, y_size]
  circles = JSON.parse(params["circles"])
  circle = Circle.new(custom_size: custom_size, circle_data: circles )


  if params[:format] ==  "jpg"
    #content_type 'image/jpeg'
    #bin = File.open(circle.file_path, 'r'){ |file| file.read }
    prefix = 'circle'
    suffix = '.jpg'
    file_path = Tempfile.new [prefix, suffix], "./tmp"
    img = Magick::ImageList.new(circle.file_path.path)
    #image = img.from_blob(circle.file_path)
    #img = image.from_blob(circle.file_path)

    img.write(file_path)
    send_file(file_path, :disposition => 'attachment', :filename => File.basename(file_path))

  else
    #content_type 'application/pdf'
    send_file(circle.file_path, :disposition => 'attachment', :filename => File.basename(circle.file_path))
    #send_file circle.file_path
  end
  #http://stackoverflow.com/questions/18621713/sinatra-prawn-example
end

get "/" do
  custom_size = [540.send(:cm), 540.send(:cm)]
  circles = [
      {label:"cerchio1", x:0, y:0, size:0.5, radius:267.5},
      {label:"cerchio2", x:0, y:0, size:0.5, radius:241.5},
      {label:"cerchio3", x:0, y:0, size:0.5, radius:218},
      {label:"cerchio4", x:0, y:0, size:0.5, radius:213.5},
      {label:"cerchio5", x:0, y:0, size:0.5, radius:198},
      {label:"cerchio6", x:0, y:0, size:0.5, radius:171.5},
      {label:"cerchio7", x:0, y:0, size:0.5, radius:160.5},
      {label:"cerchio8", x:0, y:0, size:0.5, radius:142},
      {label:"cerchio9", x:0, y:0, size:0.5, radius:133.5},
      {label:"cerchio10", x:0, y:0, size:0.5, radius:124.5},
      {label:"cerchio11", x:0, y:0, size:0.5, radius:108.5},
      {label:"cerchio12", x:0, y:0, size:0.5, radius:103.5},
      {label:"cerchio13", x:0, y:0, size:0.5, radius:87.5},
      {label:"cerchio14", x:0, y:0, size:0.3, radius:60.35454791614575},
      {label:"cerchio15", x:0, y:0, size:0.5, radius:59},
      {label:"cerchio16", x:0, y:0, size:0.3, radius:54.48831148317455},
      {label:"cerchio17", x:0, y:0, size:0.3, radius:49.1861362456814},
      {label:"cerchio18", x:0, y:0, size:0.3, radius:48.17082609382101},
      {label:"cerchio19", x:0, y:0, size:0.3, radius:44.67364668185742},
      {label:"cerchio20", x:0, y:0, size:0.3, radius:38.69459800979065},
      {label:"cerchio21", x:0, y:0, size:0.3, radius:36.21272874968746},
      {label:"cerchio22", x:0, y:0, size:0.3, radius:32.03867590315027},
      {label:"cerchio23", x:0, y:0, size:0.3, radius:30.12086783852508},
      {label:"cerchio24", x:0, y:0, size:0.5, radius:29.5},
      {label:"cerchio26", x:0, y:0, size:0.3, radius:28.09024753480429},
      {label:"cerchio27", x:0, y:0, size:0.3, radius:24.4802558837451},
      {label:"cerchio28", x:0, y:0, size:0.3, radius:23.35213349278911},
      {label:"cerchio29", x:0, y:0, size:0.3, radius:19.74214184172992},
      {label:"cerchio30", x:0, y:0, size:0.3, radius:13.31184421328075},
      {label:"cerchio31", x:0, y:0, size:0.3, radius:6.65592210664037}
  ]
  haml :index
end

