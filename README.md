# AHAB Client

Client Library for the AHAB asset packaging system: [ahab.io](http://ahab.io).

## Includes

 * Command-Line Interface
 * `Ahab::Client` Ruby API
 * `Ahab::Task` Rake task to fetch assets

## Will Include

 * `Ahab::Guard` Guard recipe to fetch assets
 * Asset registries
 * Optimistic version matching

## ahab.js

Ahab depends on an `ahab.json` file in your project's root directory. Its
structure looks like this:

```json
{
  "assets": [
    {
      "url": "http://cdnjs.cloudflare.com/ajax/libs/960gs/0/960.css"
    },
    {
      "url": "http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.js",
      "filename": "jQuery.js"
    }
  ]
}
```

## Command-Line Interface

Run `ahab fetch` once you have your `ahab.json` set up.

## Rake Task

Usage:

```ruby
namespace :assets do
  Ahab::FetchTask.new(:fetch)
end
```

```bash
rake assets:fetch
```
