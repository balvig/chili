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
- have all new controllers inherit from Chili::ApplicationController
- documentation

### Obstacles

- Have to add gemspec to main app
- Scaffold adds routes both to engine and main routes file
- Deface caches overrides in production. Monkey patch?
- Can only have one override per engine per partial due to the way I'm grabbing the class from the override
- Where to get the database.yml file from?
- Rspec generators don't namespace properly
