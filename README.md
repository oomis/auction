# Requirements
You'll need the following installed to run the application successfully:

Ruby 2.5 or higher
Redis - For ActionCable support
bundler - `gem install bundler`
rails - `gem install rails`
Yarn - `brew install yarn` or Install Yarn
Foreman (optional) - `gem install foreman` - helps run all your processes in development

# Run app
`git clone https://github.com/oomis/auction.git`

# Bundle
run `bundle install`

# Migrate db
`rails db:create`
`rails db:migrate`
if you want to run the seeded db (random values)
`rails db:seed`


# Running your app
To run your app, use `foreman start`. Foreman will run `Procfile.dev` via `foreman start -f Procfile.dev` as configured by the `.foreman` file and will launch the development processes `rails server`, `sidekiq`, and `webpack-dev-server` processes.

You can also run them in separate terminals manually if you prefer.

