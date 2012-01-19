$:.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'fakefs'
require 'vpm'

ENV['VPM_VIM_DIR'] = File.expand_path(File.dirname(__FILE__))
