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
          self.line_width = c[:size].send(:cm)
          circle [x_center_offset + c[:x], y_center_offset + c[:y]], c[:radius].send(:cm)
        end
      end
    end

  end
end