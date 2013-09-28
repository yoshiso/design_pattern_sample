#-*- coding:utf-8 -*-

#Iterator Pattern

#集約オブジェクトがもとにある内部表現を公開せずに、その要素にアクセスする方法を提供する
#要素の集まりを持つオブジェクトの各要素に順番にアクセスする方法を提供するデザインパターン


#Blog         : 複数のArticleを持つ
#Article      : Blogの個別要素
#BlogIterator : Blogの各Articleにアクセスするためのクラス

class Article

  def initialize(title)
    @title = title
  end

  attr_reader :title

end


class Blog

  def initialize
    @articles = []
  end

  def add_article(article)
    @articles << article
  end

  def get_article_at(index)
    @articles[index]
  end

  def length
    @articles.size
  end

  def iterator
    BlogIterator.new(self)
  end

end



class BlogIterator
  def initialize(blog)
    @blog = blog
    @index = 0
  end

  def has_next?
    @index < @blog.length
  end

  def next_article
    article = self.has_next? ? @blog.get_article_at(@index) : nil
    @index += 1
    article
  end
end


if __FILE__==$PROGRAM_NAME
  blog = Blog.new
  blog.add_article(Article.new('記事１'))
  blog.add_article(Article.new('記事２'))
  blog.add_article(Article.new('記事３'))
  blog.add_article(Article.new('記事４'))

  iterator = blog.iterator
  while iterator.has_next?
    article = iterator.next_article
    puts article.title
  end
end

