require 'rubygems'
require 'gosu'
Dir.glob("classes/*.rb").each {|f| require File.absolute_path(f)}

window = GameWindow.new
window.show