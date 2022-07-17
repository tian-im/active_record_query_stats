# frozen_string_literal: true

require 'test_helper'

module ActiveRecordQueryStats
  class SummaryTest < Minitest::Test
    def test_initial_values
      subject = Summary.new
      Summary::STATS.each do |field|
        assert_equal subject.try(field), 0
      end
    end

    def test_increase_methods
      subject = Summary.new
      Summary::STATS.each do |field|
        assert_equal subject.try(field), 0
        assert_equal subject.try("increase_#{field}"), 1
        assert_equal subject.try(field), 1
        assert_equal subject.try("increase_#{field}"), 2
        assert_equal subject.try(field), 2
      end
    end

    def test_to_payload
      subject = Summary.new
      assert_equal subject.to_payload,
                   { total: 0, real: 0, cached: 0, select: 0, insert: 0, update: 0, delete: 0, transaction: 0, savepoint: 0, lock: 0,
                     rollback: 0, other: 0 }
      subject.increase_total
      subject.increase_real
      subject.increase_select
      assert_equal subject.to_payload,
                   { total: 1, real: 1, cached: 0, select: 1, insert: 0, update: 0, delete: 0, transaction: 0, savepoint: 0, lock: 0,
                     rollback: 0, other: 0 }
      subject.increase_total
      subject.increase_real
      subject.increase_insert
      assert_equal subject.to_payload,
                   { total: 2, real: 2, cached: 0, select: 1, insert: 1, update: 0, delete: 0, transaction: 0, savepoint: 0, lock: 0,
                     rollback: 0, other: 0 }
    end
  end
end
