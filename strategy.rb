#Strategy Pattern


#* コンテキスト(Context)：ストラテジの利用者
#* 抽象戦略(Strategy)：同じ目的をもった一連のオブジェクトを抽象化したもの
#* 具象戦略(ConcreteStrategy)：具体的なアルゴリズム

#* Report(コンテキスト)：レポートを表す
#* Formatter(抽象戦略)：レポートの出力を抽象化したクラス
#* HTMLFormatter(具象戦略１)：HTMLフォーマットでレポートを出力
#* PlaneTextFormatter(具象戦略２)：PlanTextフォーマットでレポートを出力

class Formatter
  def output_report(title,text)
    raise "Called abstract method!"
  end
end

class HTMLFormatter

  def output_report(report)
    puts "<html><head><title>#{report.title}</title></head><body>"
    report.text.each { |line| puts "<p>#{line}</p>" }
    puts '</body></html>'
  end

end

class PlaneTextFormatter

  def output_report(report)
    puts "***** #{report.title} *****"
    report.text.each { |line| puts(line) }
  end

end

class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = "title"
    @text = %w{text2 test 2 dfsdfs}
    @formatter = formatter
  end

  def change_formatter(formatter)
    @formatter = formatter
    puts "formatter changed\n"
  end

  def output_report
    @formatter.output_report(self)
  end
end


if __FILE__==$PROGRAM_NAME
  report = Report.new(HTMLFormatter.new)
  report.output_report
  puts "------------------"
  report.change_formatter(PlaneTextFormatter.new)
  report.output_report
end
