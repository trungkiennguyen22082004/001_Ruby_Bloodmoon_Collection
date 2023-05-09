# Author: MOON

require 'rubygems'
require 'gosu'
require 'ruby2d'
require './Games/Games_Menu.rb'

records = Array.new()

# Open the Main menu window with the intro screen appearance first
Menu.new(0, records).show