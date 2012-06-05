# Chili [![Build Status](https://secure.travis-ci.org/balvig/chili.png?branch=master)](http://travis-ci.org/balvig/chili)

Have you ever wanted to test out a new feature on only a subset of users?
Did that implementation end up being lots of if/else statements embedded in the main code?
If so, Chili can help.

Chili is built on top of Rails Engines and Deface and allows you to conditionally add new/modify existing views,
while leaving the main code untouched.

## Installation

First add chili to your app's Gemfile:

```ruby
gem 'chili'
```

and run `bundle`.

## Usage

Chili extensions are like mini apps that are created inside your main app's vendor directory using using the "chili" generator.

### Creating a new chili extension

As an example, assuming you want to add a new extension named "social" that exposes a new social feature in the form of a like-button
to a subset of users, first within your main app run:

    $ rails g chili social

This is basically a shortcut for running the `rails plugin new` engine generator with a custom template and will:

1. Create a the directory `vendor/chili_social` containing the basic structure for the extension
2. Add a reference to the extension to the main app gemfile

Since the extension is mounted as a gem you'll have to run `bundle`
after this to start using the extension.

### Define who can see the extension

Use the active_if block to control whether new controllers/overrides are visible or not.
The context of the active_if block is the application controller so you can use any methods available to that.

```ruby
# lib/chili_social.rb
module ChiliSocial
  extend Chili::Activatable
  active_if { logged_in? && current_user.admin? } # Extension is only visible to logged in admin users
end
```

### Modifying view templates in main app

Chili uses deface to modify existing view templates (see [deface docs](https://github.com/railsdog/deface#using-the-deface-dsl-deface-files) for details)
Add overrides to the `app/overides` directory mirroring the path of the view you want to modify.
For example, assuming the main app has the partial `app/views/posts/_post.html.erb`:

```erb
<% # app/overrides/posts/_post/like_button.html.erb.deface (folder should mirror main app view path) %>
<!-- insert_bottom 'tr' -->
<td><%= link_to 'Like!', chili_social.likes_path(like: {post_id: post}), method: :post %></td>
```

### Adding new resources

Go to the extension's directory and use `rails g scaffold Like`. The new resource will be namespaced to ChiliSocial::Like
and automounted in the main app at `/chili/social/likes`, but only accessible when active_if is true.
All the rules for using [isolated engine models](http://railscasts.com/episodes/277-mountable-engines?view=asciicast) apply.

### Migrations

Migrations are handled the same way as engines. Use the
following commands after you've added a new migration to your extension:

    $ rake chili_social:migrations:install
    $ rake db:migrate

### Modifying existing models

Create a model with the same name as the one you want to modify by running: `rails g model User --migration=false` inside your extension's directory
and edit it to inherit from the original:

```ruby
# app/models/chili_social/user.rb
module ChiliSocial
  class User < ::User
    has_many :likes
  end
end
```

Access in your overrides/extension views through the namespaced model:

```erb
<%= ChiliSocial::User.first.likes %>
<%= current_user.becomes(ChiliSocial::User).likes %>
```

### Stylesheets/javascripts

Files added to the extension's `app/assets/chili_social/javascripts|stylesheets` directory are automatically injected into the layout using a pre-generated override:

```erb
<% # app/overrides/layouts/application/assets.html.erb.deface %>
<!-- insert_bottom 'head' -->
<%= stylesheet_link_tag 'chili_social/application' %>
<%= javascript_include_tag 'chili_social/application' %>
```

If you don't need any css/js in your extension, you can remove this file.

## Gotchas

- Chili will not be able to automount if you use a catch-all route in your main app (ie `match '*a', to: 'errors#routing'`), you will have to remove the catch-all or manually add the engine to the main app's routes file.
- Just like normal engines, Chili requires you to prepend path helpers with `main_app` (ie `main_app.root_path` etc) in view templates that are shared with the main app (such as the main app's application layout file).
