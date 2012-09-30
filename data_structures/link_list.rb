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

def create_a_curcular_linked_list
  head = LinkedList.new(0)
  curr_p = head
  for i in (1..5)
    curr_p.next = LinkedList.new(rand(1..30))
    curr_p = curr_p.next
  end
  curr_p.next = head
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
    data << ll.data
    ll = ll.next
  end
  puts data.to_s
end

def reverse(ll)
  prev = nil
  curr = ll
  nex = ll.next
  
  while nex
    curr.next = prev
    prev = curr
    curr = nex
    nex = nex.next
  end
  curr.next = prev
  curr
end

def is_circular(ll)
  fast = ll.next
  slow = ll
  if ll.nil?
    return false
  end

  while fast != slow and fast.next != slow and !fast.nil? and !slow.nil?
    fast = fast.next
    if !fast.nil?
      fast = fast.next
    else
      return false
    end
    slow = slow.next
  end
  return fast == slow || fast.next == slow
end

ll = create_a_link_list
puts "ll size is #{ll_size(ll)}"
puts "ll elements are:"
ll_print(ll)
ll = reverse(ll)
puts "reveresed:"
ll_print(ll)

circular_ll = create_a_curcular_linked_list
"is new linked list curcular?"
puts is_circular(circular_ll)
"is not circular linked list circular?"
puts is_circular(ll)
