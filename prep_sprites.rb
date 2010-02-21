require 'rubygems'
require 'rmagick'
include Magick

def split_image(file, h, v, dir, trans)
  img = Image.read(file).first
  wd = img.columns / h
  hg = img.rows / v
  h.times do |x|
    v.times do |y|
      t = img.crop(wd * x, hg * y, wd, hg)
      t = t.matte_replace(0, 0) if trans
      t.write("#{dir}/#{y}_#{x}.png") do
        self.depth = 8
      end
    end
  end
end

def process(dir, h, v, trans)

  Dir.glob("#{dir}/*.png").each do |png|
    dir_name = "#{dir}/#{File.basename png, ".png"}"
    Dir.mkdir(dir_name) unless File.exist?(dir_name)
    split_image(png, h, v, dir_name, trans)
    puts "#{png} processed"
  end
  
end

process "resources/images/characters", 3, 4, true
process "resources/images/tilesets", 4, 16, false