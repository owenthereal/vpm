$:.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
begin; require 'turn'; rescue LoadError; end


require 'vpm'
