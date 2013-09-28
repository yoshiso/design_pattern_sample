#-*- cofing:utf-8

#すべてのコマンドのインターフェイスを規定するcommandクラス
class Command

  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute
  end

  def undo_execute
  end

end

require 'fileutils'

class CreateFileCommand < Command

  def initialize(path,contents)
    super("Create file : #{path}")
    @path = path
    @contents = contents
  end

  def execute
    f = File.open(@path,"w")
    f.write(@contents)
    f.close
  end

  def undo_execute
    File.delete(@path)
  end

end

#ファイルを削除する命令
class DeleteFileCommand < Command
  def initialize(path)
    super("Delete file : #{path} ")
    @path = path
  end

  def execute
    if File.exists?(@path)
      @content = File.read(@path)
    end
    File.delete(@path)
  end

  def undo_execute
    f = File.open(@path,"w")
    f.write(@content)
    f.close
  end
end

#ファイルをコピーする命令

class CopyFileCommand < Command
  def initialize(source,target)
    super("Copy file #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    FileUtils.copy(@source,@target)
  end

  def undo_execute
    File.delete(@target)
    if(@contents)
      f = File.open(@target,"w")
      f.write(@contents)
      f.close
    end
  end
end


#コマンドを複合して実行できるクラス

class CompositeCommand < Command
  def initialize
    @commands = []
  end

  # @params cmd Commandクラスのサブクラスのインスタンス
  def add_command(cmd)
    @commands << cmd
  end

  def execute
    @commands.each { |cmd| cmd.execute }
  end

  def undo_execute
    @commands.reverse.each{ |cmd| cmd.undo_execute }
  end

  def description
    description = ""
    @commands.each { |cmd| description += cmd.description+"\n"}
    description
  end
end


if __FILE__==$PROGRAM_NAME
  command_list = CompositeCommand.new
  command_list.add_command(CreateFileCommand.new('file1.txt',"hello world!\n"))
  command_list.add_command(CopyFileCommand.new('file1.txt',"file2.txt"))
  command_list.add_command(DeleteFileCommand.new('file1.txt'))

  command_list.execute

  puts command_list.description

  command_list.undo_execute
end


