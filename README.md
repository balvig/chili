# Chili

The spicy extension framework

## Installation

Add this line to your application's Gemfile:

    gem 'chili'

## Roadmap

### Core features

Unobtrusively(!)...

- add new models `done`
- add new tables/migrations `done`
- add new controllers and show/hide conditionally `done`
- add new views and show/hide conditionally `done`
- conditionally add to/edit existing views `done`
- add methods to existing models `inprogress`
- modify existing controller actions

### Utility features

- test extension within app `inprogress`
- run app/engine specs together `inprogress`
- more ruby-like way of specifying conditions (block etc) `done`
- documentation
- generator template to create new extension with everything set up
    - remove application controller `done`
    - add overrides directory `done`
    - modify spec_helper `done`
    - set up Rakefile `done`
    - automount routes in routes.rb `done`
    - add rspec stuff to engine.rb `done`
    - remove Gemfile, Gemfile.lock `done`
    - add submodule/symlink to real app `done`
    - add active_if to main file `done`
    - add dummy override `done`
    - have all new controllers inherit from Chili::ApplicationController

### Obstacles

- Have to add gemspec to main app
- Scaffold adds routes both to engine and main routes file
- Deface caches overrides in production. Monkey patch?
- Can only have one override per engine per partial due to the way I'm grabbing the class from the override
- Where to get the database.yml file from?
- Rspec generators don't namespace properly
