def knight_moves(startpoint,endpoint)
  move_set = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]  ##possible connections
  queue = [startpoint]  #set up queue
  visited = [startpoint] #set up visited to make sure you dont loop infinitely
  path = Hash.new { |h, k| h[k] = [] } #to add multiple branches to a parent
  answer = [endpoint] 

  while queue != []
    current = queue.shift #process first item in queue, and take it out of queue
    move_set.each do |move|
      if make_move(current, move) && !visited.include?(make_move(current, move))  #if the move isn't out of bounds && not yet visited
        visited << make_move(current, move)  #then add it to visited
        queue << make_move(current, move)   # and add it to queue
        key = current
        value = make_move(current, move) 
        path[key] << value                  #and keep track of parent:child relationship so we can backtrace to find the path
      end
      break if visited.include?(endpoint)  #keep looping until we find
    end
  end

  while answer[0] != startpoint           #keep adding values to answer until we arrive at the starting point
    parent_node = path.find {|key,values| values.include?(answer[0])}&.first  #the parent = the key that includes the value
    answer.unshift(parent_node)                                                #we set answer[0] = endpoint so we look backwards
  end


  puts "You made it in #{answer.length-1} moves! Here's your path:"

  answer.each do |answer|
    p answer
  end
end

def make_move(currentpoint, move)
  x = currentpoint[0] + move[0]
  y = currentpoint[1] + move[1]
  if (x >= 0) && #make sure the move wouldn't result in out of bounds. if it does, just ignore it.
      (x <= 7) &&
      (y >= 0) &&
      (y <= 7)
   return [x,y]
  else
    return
  end
end

knight_moves([3,3],[4,3])