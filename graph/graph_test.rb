# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require 'minitest/autorun'
require_relative 'node'

# Confirms graph operations work correctly
class GraphTest < Minitest::Test

  ('A'..'G').each { |label| const_set(label.to_sym, Node.new(label)) }
  B > A
  B > C > D > E > B > F
  C > D
  C > E

  def test_can_reach
    assert B.can_reach A
    assert B.can_reach C
    assert C.can_reach F
    refute G.can_reach B
    refute A.can_reach B
    refute B.can_reach G
  end

  def test_hop_count
    assert_equal 0, A.hop_count(A)
    assert_equal 1, B.hop_count(A)
    assert_equal 1, B.hop_count(C)
    assert_equal 4, C.hop_count(F)
    assert_raises(RuntimeError) { A.hop_count B }
    assert_raises(RuntimeError) { B.hop_count G }
  end

end