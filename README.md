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
- more ruby-like way of specifying conditions (block etc)
- generator template to create new extension with everything set up
    - remove application controller `done`
    - add conditions to main file
    - add overrides directory `done`
    - modify spec_helper `done`
    - set up Rakefile    
    - add rspec stuff to engine.rb
    - automount routes in routes.rb
    - remove Gemfile, Gemfile.lock `done`
    - add submodule/symlink to real app
    - have all new controller inherit from Chili::ApplicationController

### Obstacles

- 2 Gemfiles: One for the engine, one for the app. `done`
- Deface caches overrides in production. Monkey patch?
- Can only have one override per engine per partial due to the way I'm grabbing the class from the override