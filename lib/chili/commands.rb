require 'active_support/core_ext/object/inclusion'

ARGV << '--help' if ARGV.empty?

aliases = {
  "g" => "generate",
  "d" => "destroy",
  "c" => "console",
  "s" => "server"
}

command = ARGV.shift
command = aliases[command] || command

require ENGINE_PATH
engine = ::Rails::Engine.find(ENGINE_ROOT)

case command
when 'generate', 'destroy'
  require 'rails/generators'
  Rails::Generators.namespace = engine.railtie_namespace
  engine.load_generators
  require "rails/commands/#{command}"

when '--version', '-v'
  ARGV.unshift '--version'
  require 'rails/commands/application'

when 'console'
  require 'rails/commands/console'
  require APP_PATH
  Rails.application.require_environment!
  Rails::Console.start(Rails.application)

when 'server'
  # Change to the application's path if there is no config.ru file in current dir.
  # This allows us to run script/rails server from other directories, but still get
  # the main config.ru and properly set the tmp directory.
  Dir.chdir(File.expand_path('../../', APP_PATH)) unless File.exists?(File.expand_path("config.ru"))

  require 'rails/commands/server'
  Rails::Server.new.tap { |server|
    # We need to require application after the server sets environment,
    # otherwise the --environment option given to the server won't propagate.
    require APP_PATH
    Dir.chdir(Rails.application.root)
    server.start
  }
else
  puts "Error: Command not recognized" unless command.in?(['-h', '--help'])
  puts <<-EOT
Usage: rails COMMAND [ARGS]

The common rails commands available for engines are:
 generate    Generate new code (short-cut alias: "g")
 destroy     Undo code generated with "generate" (short-cut alias: "d")
 console     Start the Rails console (short-cut alias: "c")
 server      Start the Rails server (short-cut alias: "s")

All commands can be run with -h for more information.
  EOT
  exit(1)
end
