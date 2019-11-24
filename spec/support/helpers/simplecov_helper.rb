require 'simplecov'

class SimpleCovHelper
  def self.report_coverage(base_dir: './coverage_results')
    SimpleCov.start 'rails' do
      minimum_coverage(95)
      merge_timeout(3600)
    end

    new(base_dir: base_dir).merge_results
  end

  attr_reader :base_dir

  def initialize(base_dir:)
    @base_dir = base_dir
  end

  def all_results
    Dir["#{base_dir}/.resultset*.json"]
  end

  def merge_results
    results = all_results.map do |file|
      SimpleCov::Result.from_hash(JSON.parse(File.read(file)))
    end

    SimpleCov::ResultMerger.merge_results(*results).tap do |result|
      SimpleCov::ResultMerger.store_result(result)
    end
  end
end
