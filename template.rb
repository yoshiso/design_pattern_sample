# -*- cofing:utf-8 -*-

#Template Method Pattern

# * 骨格としての「抽象的なベースのクラス」
# * 実際の処理を行う「サブクラス」

#* Report(抽象的なベースのクラス)： レポートを出力する
#* HTMLReport(サブクラス)： HTMLフォーマットでレポートを出力
#* PlaneTextReport(サブクラス)： PlanTextフォーマットでレポートを出力


class Report
  def initialize
    @title ="html report title"
    @text = ["line1","line2","line3"]
  end

  def output_report
    output_start
    output_body
    output_end
  end

  def output_start
  end

  def output_body
    @text.each do |line|
      output_line line
    end
  end

  #本文のラインの出力部分
  #個別クラスに規定する
  def output_line(line)
    raise "Called abstract method!"
  end

  def output_end
  end
end


class HTMLReport < Report
  def output_start
    puts "<html><head><title>#{@title}</title></head><body>"
  end

  def output_line(line)
    puts "<p>#{line}</p>"
  end

  def output_end
    puts "</body></html>"
  end
end


class PlaneReposrt < Report
  def output_start
    puts "***#{@title}***"
  end
  def output_line(line)
    puts line
  end
end


if __FILE__==$PROGRAM_NAME
  html_report = HTMLReport.new
  html_report.output_report

  puts "-------------------------------"

  planetext_report = PlaneReposrt.new
  planetext_report.output_report

end