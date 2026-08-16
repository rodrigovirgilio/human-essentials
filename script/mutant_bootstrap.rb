# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
Rails.application.eager_load!
require_relative "../lib/quality"
require_relative "../lib/quality/coverage_parser"
require_relative "../lib/quality/flog_parser"
require_relative "../lib/quality/rubocop_parser"
require_relative "../lib/quality/mutant_parser"
require_relative "../lib/quality/brakeman_parser"
require_relative "../lib/quality/report"
