class DistinctSelect < Select #:nodoc:
  class << self
    def [](*columns)
      self.new("select distinct #{create_columns_list(columns)}")
    end
  end
end