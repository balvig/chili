# Chili

Have you ever wanted to test out a new feature on only a subset of users?
Did that implementation end up being lots of if/else statements embedded in the main code?
If so, Chili can help.

Chili is built on top of Rails Engines and Deface and allows you to conditionally add new/modify existing views, 
while leaving the main code untouched.

## Usage

### Creating a new chili extension

Assuming you want to add a new extension that adds exposes a new "like" button feature to a subset of users, first run:

    chili likes

This is basically a shortcut for running the `rails plugin new` engine generator with a custom template.

The script will prompt you for the location of your main app repository to which you are adding the chili extension.
The repo will be added as a submodule in the main_app directory.

### Prepare main app

- add `gem 'deface', git: 'git://github.com/railsdog/deface.git', branch: 'dsl'` to main_app/Gemfile
- add `gemspec path: '../'` to main_app/Gemfile
- run `bundle` within the main_app directory.

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

Add an override (see [deface docs](https://github.com/railsdog/deface#readme) for details) with the same name as the extension.
As an example, assuming the main app has the partial `app/views/posts/_post.html.erb`:

```erb
<% # app/overrides/posts/_post/chili_likes.html.erb.deface (folder should mirror main app view path) %>
<!-- insert_bottom 'tr' -->
<td><%= link_to 'Like!', chili_likes.likes_path(like: {post_id: post}), method: :post %></td>
```

### Adding new resources

Use `rails g scaffold Like` as usual when using engines. The new resource will be namespaced to ChiliLikes::Like
and automounted in the main app at `/chili_likes/likes`, but only accessible when active_if is true. 
All the rules for using [engine-based models](http://railscasts.com/episodes/277-mountable-engines?view=asciicast) apply.

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

### Gotchas

- Chili will not be able to automount if you use a catch-all route in your main app (ie `match '*a', to: 'errors#routing'`), you will have to remove the catch-all or manually add the engine to the main app's routes file.
- Just like normal engines, Chili requires you to prepend path helpers with `main_app` (ie `main_app.root_path` etc) in view templates that are shared with the main app (such as the main app's application layout file).

## Roadmap

### Current Issues

- Deface caches overrides in production. Monkey patch?
- Haven't found a good way to modify existing controller actions

### Minor niggles

- Have to add gemspec to main app
- Can only have one override per engine per partial due to the way I'm grabbing the class from the override
- Need to use DSL branch from deface
- Request specs don't have access to path helpers