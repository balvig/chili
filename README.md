# 🌶️ Chili

Have you ever wanted to test out a new feature on only a subset of users?
Did that implementation end up being lots of if/else statements embedded in the main code?
If so, Chili can help.

Chili is built on top of Rails Engines and Deface and allows you to conditionally add new/modify existing views,
while leaving the main code untouched.

## Tutorial & Examples

- [Walkthrough of creating and releasing a new feature with Chili](https://balvig.github.io/chili/)

## Requirements

- Rails 4.1+
- Ruby 1.9.2+

## Installation

First add Chili to your app's Gemfile:

```ruby
gem 'chili'
```

and run `bundle`.

## Usage

Chili features are like mini apps that are created inside your main app's lib/chili directory using using the "chili" generator.

### Creating a new chili feature

As an example, assuming you want to add a beta feature named "social" that shows a new like-button
to a subset of users, first within your main app run:

```bash
$ rails g chili:feature social
```

This will:

1. Create the directory `lib/chili/social_feature` containing the basic structure for the feature
2. Add a reference to the feature to the main app gemfile

Since the feature is mounted as a gem you'll have to restart the app.

### Define who can see the feature

Use the active_if block to control whether new the feature is active for each user.
The context of the active_if block is the application controller so you can use any methods available to that.

```ruby
# {feature}/lib/social_feature.rb
module SocialFeature
  extend Chili::Base
  active_if { logged_in? && current_user.admin? } # Feature is only visible to logged in admin users
end
```

### Modifying view templates in main app

Chili uses Deface to dynamically modify existing view templates (see [Deface docs](https://github.com/spree/deface#using-the-deface-dsl-deface-files) for details)
To generate an override to the feature, run the deface generator specifying the name of the feature and path to the template you want to modify.
For example, assuming the main app has the partial `app/views/posts/_post.html.erb` run:

```bash
$ rails g social_feature deface:override posts/_post like_button
```

This will create a dummy override at `{feature}/app/overrides/posts/_post/like_button.html.erb.deface` that you can edit:

```erb
<% # {feature}/app/overrides/posts/_post/like_button.html.erb.deface %>
<!-- insert_bottom 'tr' -->
<td><%= link_to 'Like!', social_feature.likes_path(like: {post_id: post}), method: :post %></td>
```

### Adding new resources

You can run the usual Rails generators for each feature by prepending
the generator with the name of the feature:

```bash
$ rails g social_feature scaffold Like
```

The new resource will be namespaced to `SocialFeature::Like` and automounted as an [isolated engine](http://railscasts.com/episodes/277-mountable-engines?view=asciicast) in the main app at `/chili/social_feature/likes`,
but will only be accessible when active_if is true.

### Migrations

To copy and run feature db migrations use the following command:

```bash
$ rake social_feature:db:migrate
```

### Modifying existing models

Create a model with the same name as the one you want to modify by running: `rails g social_feature model User --migration=false` and edit it to inherit from the original:

```ruby
# {feature}/app/models/social_feature/user.rb
module SocialFeature
  class User < ::User
    has_many :likes
  end
end
```

Access in your overrides/feature views through the namespaced model:

```erb
<%= SocialFeature::User.first.likes %>
<%= current_user.becomes(SocialFeature::User).likes %>
```

### Stylesheets/javascripts

Files added to the feature's `app/assets/social_feature/javascripts|stylesheets` directory are automatically injected into the layout using a pre-generated override:

```erb
<% # {feature}/app/overrides/layouts/application/assets.html.erb.deface %>
<!-- insert_bottom 'head' -->
<%= stylesheet_link_tag 'social_feature/application' %>
<%= javascript_include_tag 'social_feature/application' %>
```

If you don't need any css/js in your feature, you can remove this file.

## Gotchas

- Chili will not be able to automount if you use a catch-all route in your main app (ie `match '*a', to: 'errors#routing'`), you will have to remove the catch-all or manually add the engine to the main app's routes file.
- Just like normal engines, Chili requires you to prepend path helpers with `main_app` (ie `main_app.root_path` etc) in view templates that are shared with the main app (such as the main app's application layout file).
