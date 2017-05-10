require "prawn"
require "prawn/measurement_extensions"
require "json"
require 'rmagick'
require 'rvg/rvg'

class Circle
  include Magick

  attr_accessor :file_path, :um, :format, :dpi
  def initialize(custom_size:, circle_data:, um: "px", format: "png", dpi: 72)
    @um, @format, @dpi = um.to_sym, format, dpi

    #draw_with_prawn(custom_size: custom_size, circle_data: circle_data)
    draw_with_magick(custom_size: custom_size, circle_data: circle_data)
  end

  def draw_with_prawn(custom_size:, circle_data:)
    prefix = 'circle'
    suffix = '.pdf'
    @file_path = Tempfile.new [prefix, suffix], "./tmp"
    Prawn::Document.generate(file_path, page_size: custom_size) do
      stroke_axis
      x_center_offset = custom_size[0] / 2
      y_center_offset = custom_size[1] / 2
      circle_data.each do |c|
        stroke do
          self.line_width = c["size"].to_f.send(:cm)
          self.stroke_color = c["color"]  if c["color"]
          circle [x_center_offset + c["x"].to_f.send("cm"), y_center_offset + c["y"].to_f.send("cm")], c["radius"].to_f.send("cm")
        end
      end
    end
  end
  def draw_with_magick(custom_size:, circle_data:)
    prefix = 'circle'
    suffix = ".#{@format}"
    @file_path = Tempfile.new [prefix, suffix], "./tmp"
    RVG::dpi = @dpi
    x , y = custom_size[0].send(@um), custom_size[1].send(@um)
    x_center_offset = x / 2
    y_center_offset = y / 2
    rvg = RVG.new( x,y) do |canvas|
      canvas.background_fill = 'white'
      canvas.g do |body|
        circle_data.each do |c|
          radius = c["radius"].to_i.send(@um)
          stroke_width =  c["size"].to_f.send(@um)
          puts [x,y,x_center_offset, y_center_offset,radius,stroke_width].to_s
          body.circle(radius,x_center_offset, y_center_offset).styles(:stroke=>'black', :stroke_width => stroke_width, fill_opacity: 0)
        end
      end

    end
    image = rvg.draw
    image.compression = LZWCompression
    #image.info.depth = 8
    image.write(file_path.path)
  end
end