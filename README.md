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
- automatically bring in stylesheets and javascripts
- modify existing controller actions

### Obstacles

- make request specs understand paths
- resource route generator adds routes both to engine and main routes file
- Deface caches overrides in production. Monkey patch?

### Minor niggles

- Can only have one override per engine per partial due to the way I'm grabbing the class from the override
- Have to add gemspec to main app
- Where to get the database.yml file from?
- Rspec generators don't namespace properly
- Need to use DSL branch from deface
- Have to restart server when adding overrides

## Docs...

### Creating a new chili extension

Assuming you want to add a new extension that adds "like" capabilities to a subset of users:

    rails plugin new chili_likes --mountable -m https://raw.github.com/balvig/chili/master/lib/chili/template.rb
    
### Prepare main app

- make sure that shared views (f.ex layouts) uses `main_app.` prefix for routes
- add `gem 'deface', git: 'git://github.com/railsdog/deface.git', branch: 'dsl'` to Gemfile
- add `gemspec path: '../'` to Gemfile
- bundle
- set up database

### Setting up activation conditions

Use the active_if block to control whether new controllers/overrides are visible or not. 
The context of the active_if block is the application controller so you can use any methods available to that.

```ruby
# lib/chili_likes.rb
module ChiliLikes
  extend Chili::Activatable
  active_if { logged_in? && current_user.admin? } # Extension is only visible to logged in admin users
end
```

### Modifying view templates in main app

See [deface docs](https://github.com/railsdog/deface#readme) for details.

```erb
<% # app/overrides/posts/_post/chili_likes.html.erb.deface (folder should mimic main app view path) %>
<!-- insert_bottom 'li' -->
<%= link_to 'Show likes', chili_likes.likes_path %>
```

### Adding new resources

Use `rails g scaffold Like' as usual when using engines. The new resource will be namespaced to ChiliExtensionName::Post
and reachable in the main app under /chili_extension/likes IF active_if returns true. All the rules for using 
[engine-based models](http://railscasts.com/episodes/277-mountable-engines?view=asciicast) apply.

### Modifying existing models

Create a model with the same name as the one you want to modify `rails g model User --migration=false` 
and extend from the original:

```ruby
# app/model/chili_likes/user.rb
module ChiliLikes
  class User < ::User
    has_many :likes
  end
end
```

Access through the namespaced model:

```erb
<%= ChiliLikes::User.first.likes %>
<%= current_user.becomes(ChiliLikes::User).likes %>
```