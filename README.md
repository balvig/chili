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
- Have to add gemspec to main app

### Minor niggles

- Can only have one override per engine per partial due to the way I'm grabbing the class from the override
- Where to get the database.yml file from?
- Rspec generators don't namespace properly
- Need to use DSL branch from deface
