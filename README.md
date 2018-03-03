# Backuppy

Prototype for backing up data via email.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'backuppy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install backuppy

## Usage

After installation you can run:

``` bash
backuppy start
```

## Configuration

You need the following env variables:

`MAIL_ADDRESS`

`MAIL_PORT`

`MAIL_USERNAME`

`MAIL_PASSWORD`

`LOGFILE` - the logfile where stuff gets logged

`ALLOWED_SENDERS` - a comma separated whitelist of allowed senders

`BACKUP_DIR` - the directory where attachmets get stored

`FETCH_INTERVAL` (optional)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
