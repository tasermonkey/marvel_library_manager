# MarvelLibraryManager

This library provides a way to add an entire series to your marvel library

## Installation

Add this line to your application's Gemfile:

    gem 'marvel_library_manager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marvel_library_manager

## Usage

now you should be able to execute 'marvel_library_manager' from your shell

Requirements:
Setting of the following env variables

```
export MARVEL_PUB_API_KEY="<your marvel pub api key>"
export MARVEL_PRIV_API_KEY="<your marvel private api key>"
export MARVEL_SERIES_ID="<comic series id>"
export MARVEL_SITE_COOKIE="The cookie that the regular site sends to the server on each request"
```

I added to the `.gitignore` file to ignore the file `.env` so that people can add the above exports to the `.env` file to source on each terminal session, and not have to worry about remembering not to commit their keys


## Contributing

1. Fork it ( https://github.com/tasermonkey/marvel_library_manager/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Attribution

Data provided by Marvel. © 2014 Marvel
