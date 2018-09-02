class ReportGenerate
  prepend SimpleCommand
  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    posts = Post.prepare_report(start_date, end_date)
    comments = Comment.prepare_report(start_date, end_date)

    report = unite(posts, comments)
    report = items_to_array(report)
    report = sort_items(report)

    report
  end

  private

  def unite(posts, comments)
    result = {}
    posts.each { |key,value| result[key] = [value, 0] }

    comments.each do |key,value|
      if result.key?(key)
        result[key][1] = value
      else
        result[key] = [0, value]
      end
    end

    result
  end

  def items_to_array(items)
    result = []
    items.each { |key,value| result << items.assoc(key).flatten }
    result
  end

  def sort_items(items)
    items.sort do |a,b|
      (a[2] + a[3]/10.0) <=> (b[2] + b[3]/10.0)
    end
  end
end