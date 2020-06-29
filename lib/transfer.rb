class Transfer

  attr_accessor :sender, :receiver, :status, :amount

  def initialize sender, receiver, amount
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
    

  end

  def valid?
    (@sender.valid? && @receiver.valid? && @status == 'pending' && ((@sender.balance - @amount) > 0))
  end

  def execute_transaction
    return reject_transaction unless self.valid?
       
    @sender.balance -= @amount
    @receiver.deposit @amount
    @status = 'complete'
  end

  def reverse_transfer
    return "Can't do it" unless @status == 'complete'

    @receiver.balance -= @amount
    @sender.deposit @amount
    @status = 'reversed'
  end

  private

  def reject_transaction
    @status = 'rejected'
    return 'Transaction rejected. Please check your account balance.'
  end





end
