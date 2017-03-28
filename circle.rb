require "prawn"
require "prawn/measurement_extensions"
require "json"



class Circle
  attr_accessor :file_path
  def initialize(custom_size:, circle_data:)
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
end