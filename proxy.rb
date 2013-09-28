#Proxy Pattern

#対象オブジェクト(subject)：本物のオブジェクト
#代理サブジェクト(proxy)：特定の「関心事」を担当、それ以外を対象サブジェクトに渡す


# 対象オブジェクト
class BankAccount
  attr_reader :balance

  def initialize(balance)
    puts "BankAccountを生成しました"
    @balance = balance
  end

  def deposite(amount)
    @balance+=amount
  end

  def withdraw(amount)
    @balance-=amount
  end
end


# ユーザー認証を行う防御Proxy
require 'etc'
class BankAccountProxy
  def initialize(bank,owner_name)
    @bank = bank
    @owner_name = owner_name
  end

  def balance
    check_access
    @bank.balance
  end

  def deposite(amount)
    check_access
    @bank.deposite(amount)
  end

  def withdraw(amount)
    check_access
    @bank.withdraw(amount)
  end

  def check_access
    if(Etc.getlogin != @owner_name)
      raise "Illegal access!#{@owner_name} cannnot access this bank"
    end
  end
end

class VirtualAccountProxy

  def initialize(starting_balance)
    puts "VirtualAccountProxyを生成しました"
    @starting_balance = starting_balance
  end

  def balance
    subject.balance
  end

  def deposite(amount)
    subject.deposite(amount)
  end

  def withdraw(amount)
    subject.deposite(amount)
  end

  def announce
    "VirtualAccountProxyが担当するアナウンスです"
  end

  def subject
    @subject ||= BankAccount.new(@starting_balance)
  end

end


if __FILE__==$PROGRAM_NAME
  account = BankAccount.new(100)
  proxy = BankAccountProxy.new(account,"yoshi")
  puts proxy.deposite(50)
  puts proxy.withdraw(120)

#  proxy = BankAccountProxy.new(account,"wrong")
#  puts proxy.deposite(10)

  puts " virtual account proxy"
  proxy = VirtualAccountProxy.new(100)
  puts proxy.announce
  puts proxy.deposite(100)
  puts proxy.withdraw(10)
end