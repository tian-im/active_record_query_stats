# [ActiveRecordQueryStats](https://github.com/tian-im/active_record_query_stats)

[![Gem Version](https://badge.fury.io/rb/active_record_query_stats.svg)](https://badge.fury.io/rb/active_record_query_stats)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintainability](https://api.codeclimate.com/v1/badges/9ba0a610043a2e1a9e74/maintainability)](https://codeclimate.com/github/tian-im/active_record_query_stats/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/9ba0a610043a2e1a9e74/test_coverage)](https://codeclimate.com/github/tian-im/active_record_query_stats/test_coverage)

ActiveRecordQueryStats is a simple ActiveRecord query stats logging based on [Active Support Instrumentation](https://guides.rubyonrails.org/active_support_instrumentation.html). It produces the stats in following format:

```shell
```

It subscribes to the following events:

- `sql.active_record`: collect and analyze the query executed by ActiveRecord from this event.
- `process_action.action_controller`: display the stats when a request is finished.

## Install

Add `ActiveRecordQueryStats` to `Gemfile`.

```ruby
gem 'active_record_query_stats'
```

And re-bundle.

```shell
bundle install
```

## Documentation

- [API Reference](https://www.rubydoc.info/gems/active_record_query_stats)
- [Change Logs](https://github.com/tian-im/active_record_query_stats/blob/master/CHANGELOG.md)

## Want to contribute?

Raise an [issue](https://github.com/tian-im/active_record_query_stats/issues/new), discuss and resolve!

## License

This project uses [MIT License](https://github.com/tian-im/active_record_query_stats/blob/master/LICENSE).
