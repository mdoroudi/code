require 'debugger'

class LinkedList
  attr_accessor :data, :next
  def initialize(value)
    @data = value
    @next = nil
  end

end

def create_a_link_list
  head = LinkedList.new(0)
  curr_p = head
  for i in (1..5)
    curr_p.next = LinkedList.new(rand(1..30))
    curr_p = curr_p.next
  end
  head
end

def ll_size(ll)
  count = 0
  while (ll)
    count += 1
    ll = ll.next
  end
  count
end

def ll_print(ll)
  data = []
  while ll
    puts ll.data
    ll = ll.next
  end
end

ll = create_a_link_list
puts "ll size is #{ll_size(ll)}"
puts "ll elements are:"
ll_print(ll)
puts "mina"
