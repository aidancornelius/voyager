# Voyager
A partial backend to a course system. Hacky at best, not currently maintained

## Usage

Add this (or similar) junk to your routes...


```
resources :completions
get 'certificate', to: 'certificate#index'
get 'pdcertificate', to: 'certificate#generate'
resources :messages
resources :lesson_components
resources :replies do
 post 'star'
end
get '/course/:course_slug/modules', to: 'units#index'
get '/course/:course_slug/modules/:module_slug/:component_slug', to: 'units#lesson_component'
resources :lessons
resources :courses do
 get 'dashboard'
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'voyager'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install voyager
```

### Finally

Run - rails voyager:install:migrations

Check - routes.rb

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
