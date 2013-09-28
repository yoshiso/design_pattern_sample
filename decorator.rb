# -*- coding:utf-8 -*-
# Decorator パターン

#具体コンポーネント: ベースとなる処理を持つオブジェクト
#デコレーター     : 具体コンポーネントに追加する機能を持つ

class SimpleWriter

  def initialize(path)
    @file = File.open(path,"w")
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

#デコレーターの共通クラス
class WriteDecorator

  def initialize(real_writer)
    @real_writer = real_writer
  end

  def write_line(line)
    @real_writer.write_line(line)
  end

  def pos
    @real_writer.pos
  end

  def rewind
    @real_writer.rewind
  end

  def close
    @real_writer.close
  end
end

#行番号出力機能を持つ
class NumberingWriter < WriteDecorator

  def initialize(real_writer)
    super(real_writer)
    @line_number=1
  end

  def write_line(line)
    @real_writer.write_line("#{@line_number} : #{line}")
    @line_number +=1
  end
end

#タイムスタンプ出力機能を持つ

class TimestampWriter < WriteDecorator

  def write_line(line)
    @real_writer.write_line("#{Time.now} : #{line}")
  end

end





if __FILE__==$PROGRAM_NAME
  writer = SimpleWriter.new('file1.txt')
  writer.write_line('飾り気のない一行')
  writer.close
  p "---------------------------------"
  number_writer = NumberingWriter.new(SimpleWriter.new('file2.txt'))
  number_writer.write_line('ナンバリングした１行')
  number_writer.write_line('ナンバリングした１行')
  number_writer.write_line('ナンバリングした１行')
  number_writer.close
  p "---------------------------------"
  timestamp_writer = TimestampWriter.new(SimpleWriter.new('file3.txt'))
  timestamp_writer.write_line('タイムスタンプド１行')
  timestamp_writer.write_line('タイムスタンプド１行')
  timestamp_writer.close
  p "-------------------------------"
  f = TimestampWriter.new(NumberingWriter.new(SimpleWriter.new("file4.txt")))
  f.write_line("両方書かれています")
  f.write_line("両方書かれています")
  f.write_line("両方書かれています")
  f.close
end