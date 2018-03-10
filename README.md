# Capistrano::File::Upload

Upload local files to remote server (plugin for Capistrano 3.x)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano', '~> 3.5'
gem 'capistrano-file-upload'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-file-upload

## Usage

Require in `Capfile` to use the default task:

```ruby
require 'capistrano/file-upload'
```

The task will run before `deploy:updated` as part of Capistrano's default deploy.

Configurable options:

```ruby
append :file_upload_files, 'config/parameters.json' # default value is []
append :file_upload_dirs, 'shared', 'web/assets'    # default value is []
set :file_upload_roles, :all                        # default
```
