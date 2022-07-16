# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'active_record_query_stats/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_record_query_stats'
  spec.version       = ActiveRecordQueryStats::VERSION
  spec.authors       = ['Tian Chen']
  spec.email         = ['me@tian.im']
  spec.license       = 'MIT'

  spec.summary       = 'Query Stats logging for ActiveRecord'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/tian-im/active_record_query_stats'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'changelog_uri' => "#{spec.homepage}/blob/master/CHANGELOG.md"
  }

  spec.files = Dir[
    'lib/**/*',
    'LICENSE',
    'README.md'
  ]

  # @see https://www.fastruby.io/blog/ruby/rails/versions/compatibility-table.html
  spec.required_ruby_version = '>= 2.5.0'

  spec.add_dependency 'actionpack', '>= 6.0.0'
  spec.add_dependency 'activerecord', '>= 6.0.0'
  spec.add_dependency 'activesupport', '>= 6.0.0'
  spec.add_dependency 'i18n'
  spec.add_dependency 'request_store'
end
