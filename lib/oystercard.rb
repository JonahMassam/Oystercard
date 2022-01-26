class Oystercard
  attr_reader :balance
  MAX_LIMIT = 90
  MIN_LIMIT = 1
  
  def initialize
    @balance = 0
    @in_journey = false
  end
  
  def top_up(amount)
    @balance += amount
    fail "Overlimit: Limit is £#{MAX_LIMIT}" if @balance > MAX_LIMIT
  end

  private def deduct(amount)
    @balance -= amount  
  end

  def touch_in
    fail "No balance: Minimum £#{MIN_LIMIT}" if @balance < MIN_LIMIT
    @in_journey = true 
  end

  def touch_out
    deduct(MIN_LIMIT)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end


end 