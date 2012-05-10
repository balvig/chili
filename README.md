# Chili

The spicy extension framework

## Roadmap

### Core features

Unobtrusively(!)...

- add new models `done`
- add new tables/migrations `done`
- add new controllers and show/hide conditionally `done`
- add new views and show/hide conditionally `done`
- conditionally add to/edit existing views `done`
- add methods to existing models `done`
- modify existing controller actions

### Utility features

- make request specs understand paths
- documentation

### Obstacles

- resource route generator adds routes both to engine and main routes file
- Deface caches overrides in production. Monkey patch?

### Minor niggles

- Can only have one override per engine per partial due to the way I'm grabbing the class from the override
- Have to add gemspec to main app
- Where to get the database.yml file from?
- Rspec generators don't namespace properly
- Need to use DSL branch from deface

## Docs...

### Creating a new chili extension

    rails plugin new chili_extension_name --mountable -m https://raw.github.com/balvig/chili/master/lib/chili/template.rb
    
### Prepare main app

- make sure that shared views (f.ex layouts) uses `main_app.` prefix for routes
- add `gem 'deface', git: 'git://github.com/railsdog/deface.git', branch: 'dsl'` to Gemfile
- add `gemspec path: '../'` to Gemfile
- bundle
- set up database