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
- add methods to existing models
- modify existing controller actions

### Utility features

- test extension within app `inprogress`
- run app/engine specs together `inprogress`
- more ruby-like way of specifying conditions (block etc)
- generator template to create new extension with everything set up
    - remove application controller
    - have all new controller inherit from Chili::ApplicationController
    - add conditions to main file
    - add overrides directory
    - set dummy path to spec
    - modify spec_helper
    - add rspec stuff to engine.rb
    - add submodule/symlink to real app
    - remove Gemfile, Gemfile.lock
    - set up Rakefile
    - automount routes in routes.rb

### Obstacles

- 2 Gemfiles: One for the engine, one for the app. `inprogress`
- Deface caches overrides in production. Monkey patch?