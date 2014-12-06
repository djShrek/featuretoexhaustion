require "bundler"

Bundler.require
Bundler.require :test

ENV["APP_ENV"] = "test"

require "config"
require "factories"


DatabaseCleaner.strategy = :transaction

class Minitest::Test
  include FactoryGirl::Syntax::Methods
end

