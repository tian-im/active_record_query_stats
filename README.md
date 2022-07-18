# [ActiveRecordQueryStats](https://github.com/tian-im/active_record_query_stats)

[![Gem Version](https://badge.fury.io/rb/active_record_query_stats.svg)](https://badge.fury.io/rb/active_record_query_stats)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintainability](https://api.codeclimate.com/v1/badges/9bcbeb90bc7f141fc211/maintainability)](https://codeclimate.com/github/tian-im/active_record_query_stats/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/9bcbeb90bc7f141fc211/test_coverage)](https://codeclimate.com/github/tian-im/active_record_query_stats/test_coverage)

ActiveRecordQueryStats produces simple ActiveRecord query stats at the end of each request in the following format:

```shell
Query Stats
-----------
total: 6, real: 5, cached: 1
select: 4, insert: 0, update: 1, delete: 0
transaction: 0, savepoint: 0, rollback: 0, lock: 0, other: 0
```

- **total:** total queries occurred during the request.
- **real:** queries having run against the database.
- **cached:** queries that Rails encounters again and returns the cached result instead of hitting the database (see [SQL Caching](https://guides.rubyonrails.org/caching_with_rails.html#sql-caching)).
- **select:** SELECT queries.
- **insert:** INSERT queries.
- **update:** UPDATE queries.
- **delete:** DELETE queries.
- **transaction:** TRANSACTION related queries.
- **savepoint:** SAVEPOINT related queries.
- **lock:** LOCK related queries.
- **rollback:** ROLLBACK related queries.
- **other:** the rest queries go here.

## Install

Add the following line to file `Gemfile`.

```ruby
gem 'active_record_query_stats', group: :development
```

And run re-bundle in terminal.

```shell
bundle install
```

That's it. Start the Rails server and see the stats!

## Configuration

The query stats template can be customized by overwriting the translation for `active_record_query_stats.stats_template`, e.g.:

```yml
# config/locales/en.yml
en:
  # ...
  active_record_query_stats:
    stats_template: |
      Query Stats
      -----------
      total: %{total}, real: %{real}, cached: %{cached}
      select: %{select}, insert: %{insert}, update: %{update}, delete: %{delete}
      transaction: %{transaction}, savepoint: %{savepoint}, rollback: %{rollback}, lock: %{lock}, other: %{other}
```

## Implementation

ActiveRecordQueryStats is based on the [Active Support Instrumentation](https://guides.rubyonrails.org/active_support_instrumentation.html) to implement the features by subscribing the following Rails events:

- `sql.active_record`: collect and analyze the query executed by ActiveRecord from this event.
- `process_action.action_controller`: display the stats when a request is finished.

## Documentation

- [API Reference](https://www.rubydoc.info/gems/active_record_query_stats)
- [Change Logs](https://github.com/tian-im/active_record_query_stats/blob/master/CHANGELOG.md)

## Want to contribute?

Raise an [issue](https://github.com/tian-im/active_record_query_stats/issues/new), discuss and resolve!

## License

This project uses [MIT License](https://github.com/tian-im/active_record_query_stats/blob/master/LICENSE).
