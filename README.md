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
- add new stylesheets and javascripts `done`
- modify existing controller actions

### Obstacles

- Deface caches overrides in production. Monkey patch?

### Minor niggles

- Have to add gemspec to main app
- Can only have one override per engine per partial due to the way I'm grabbing the class from the override
- Need to use DSL branch from deface
- Have to restart server when adding overrides
- Request specs don't have access to path helpers

## Docs...

### Creating a new chili extension

Assuming you want to add a new extension that adds "like" capabilities to a subset of users, run:

    chili likes

This is basically a shortcut for running the rails engine generator with
a custom template:

    rails plugin new chili_likes --mountable -m https://raw.github.com/balvig/chili/master/lib/chili/template.rb

The script will prompt you for the location of your main app repository to which you are adding the chili extension.
The repo will be added as a submodule in the main_app directory.

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
As an example, assuming the main app has a partial at `app/views/posts/_post.html.erb`:

```erb
<% # app/overrides/posts/_post/chili_likes.html.erb.deface (folder should mimic main app view path) %>
<!-- insert_bottom 'li' -->
<%= link_to 'Show likes', chili_likes.likes_path %>
```

### Adding new resources

Use `rails g scaffold Like` as usual when using engines. The new resource will be namespaced to ChiliLikes::Like
and automounted in the main app at `/chili_extension/likes` if active_if is true. All the rules for using
[engine-based models](http://railscasts.com/episodes/277-mountable-engines?view=asciicast) apply.

### Modifying existing models

Create a model with the same name as the one you want to modify: `rails g model User --migration=false`
and inherit from the original:

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

### Adding new stylesheets/javascripts

Add files as usual in `app/assets/chili_likes/javascripts|stylesheets` and inject them into the layout using an override:

```erb
<% # app/overrides/layouts/application/chili_likes.html.erb.deface %>
<!-- insert_bottom 'head' -->
<%= stylesheet_link_tag 'chili_likes/application' %>
<%= javascript_include_tag 'chili_likes/application' %>
```
