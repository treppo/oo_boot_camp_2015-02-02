# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a specific measurement
class IntervalQuantity
  include Comparable
  attr_reader :amount, :unit
  protected :amount, :unit

  EPSILON = 0.0000001

  def initialize(amount, unit)
    @amount, @unit = amount, unit
  end

  def ==(other)
    return false unless other.is_a? self.class
    return false unless self.unit.compatible?(other.unit)
    (self.amount - converted_amount(other)).abs < EPSILON
  end

  def <=>(other)
    return 0 if self == other
    self.amount <=> converted_amount(other)
  end

  def hash
    unit.amount_hash(amount)
  end

  def better_than?(other)
    (self <=> other) > 0
  end

  private

    def converted_amount(other)
      @unit.converted_amount(other.unit, other.amount)
    end

end
