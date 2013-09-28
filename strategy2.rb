class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = 'report title'
    @text = %w{test test test}
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end

end


HTML_FORMATTER = lambda do |context|
  puts "<html><head><title>#{context.title}</title></head><body>"
  context.text.each { |line| puts "<p>#{line}</p>" }
  puts '</body></html>'
end

PLANE_TEXT_FORMATTER = lambda do |context|
  puts "***** #{context.title} *****"
  context.text.each { |line| puts(line) }
end


if __FILE__==$PROGRAM_NAME
  report = Report.new(&HTML_FORMATTER)
  report.output_report
  report.formatter=PLANE_TEXT_FORMATTER
  report.output_report
end