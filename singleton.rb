# -*- cofing: utf-8 -*-
#作成したクラスが唯一のインスタンスを自身で作成し、所有する
require 'singleton'

class SingletonObject
  include Singleton
  attr_accessor :counter

  def initialize
    @counter = 0
  end

end

if __FILE__== $PROGRAM_NAME
  obj1 = SingletonObject.instance
  obj1.counter+=1

  puts obj1.counter
  #>1

  obj2 = SingletonObject.instance
  obj2.counter +=1

  puts obj2.counter
  #>2

end