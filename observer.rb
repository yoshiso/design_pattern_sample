
# サブジェクト(subject)：変化する側のオブジェクト
# オブザーバ(Observer)：状態の変化を関連するオブジェクトに通知するインタフェース
# 具象オブザーバ(ConcreteObserver)：状態の変化に関連して具体的な処理を行う

# Employee(サブジェクト)：従業員を表す
# Observable(オブザーバ)：従業員のニュースを監視する仕組み(observer/Observable)
# Payroll(具体オブザーバ１)：給与の小切手の発行を行う
# TaxMan(具体オブザーバ２)：税金の請求書の発行を行う
# http://www.ruby-doc.org/stdlib-2.0.0/libdoc/observer/rdoc/Observable.html#method-i-add_observer

require 'observer'

class Employee
  include Observable

  attr_reader :name, :address, :salary


  def initialize(name,title,salary)
    @name = name
    @title = title
    @salary = salary
    add_observer(Payroll.new)
    add_observer(TaxMan.new)
  end

  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
end

class Payroll

  def update(changed_employee)
    puts "彼の給料は#{changed_employee.salary}になりました。#{changed_employee.name}のために新しい小切手を切ります。"
  end

end

class TaxMan
  def update(changed_employee)
    puts "#{changed_employee.name}に新しい税金の請求書を送ります。"
  end
end



if __FILE__==$PROGRAM_NAME

  john = Employee.new('John','Senior Vice President',5000)
  john.salary = 6000
  john.salary = 7000
end