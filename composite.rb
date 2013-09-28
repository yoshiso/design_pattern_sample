#コンポーネント(Component)：すべてのオブジェクトの基底となるクラス
#リーフ(Leaf)：プロセスの単純な構成要素、再帰しない
#コンポジット(Composite)：コンポーネントの一つでサブコンポーネントで構成
#
#FileEntryクラス(Leaf)：ファイルを表す
#DirEntryクラス(Composite)：ディレクトリを表す
#Entryクラス(Component)：FileEntry, DirEntryクラスの共通メソッドを規定


class Entry
  def get_name; end

  def ls_entry(prefix); end

  def remove; end
end


class FileEntry < Entry

  def initialize(name)
    @name=name
  end

  def get_name
    @name
  end

  def ls_entry(prefix)
    puts prefix + "/" + get_name
  end

  def remove
    puts @name + "を削除しました"
  end

end


class DirEntry < Entry

  def initialize(name)
    @name=name
    @directory = []
  end

  def get_name
    @name
  end

  def add(entry)
    @directory << entry
  end

  def ls_entry(prefix)
    puts "#{prefix}/#{get_name}"
    @directory.each do |e|
      e.ls_entry("#{prefix}/#{get_name}")
    end
  end


  def remove
    @directory.each do |e|
      e.remove
    end
    puts "#{@name}を削除しました"
  end

end




if __FILE__==$PROGRAM_NAME
  root = DirEntry.new('root')
  tmp = DirEntry.new('tmp')
  tmp.add(FileEntry.new('conf'))
  tmp.add(FileEntry.new('data'))
  root.add(tmp)
  root.ls_entry('')
  root.remove
end