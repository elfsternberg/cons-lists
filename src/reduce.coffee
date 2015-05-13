{car, cdr, cons, listp, pairp, nilp, nil, list, listToString} = require './lists'

reduce = (lst, iteratee, memo, context) ->
  count = 0
  return memo if nilp lst
  memo = iteratee.call(context, memo, (car lst), count)
  lst = cdr lst
  count++
  while not nilp lst
    memo = iteratee.call(context, memo, (car lst), count)
    count++
    lst = cdr lst
    null
  memo

map = (lst, iteratee, context) ->
  return nil if nilp lst
  root = cons()

  reducer = (memo, item, count) ->
    next = cons(iteratee.call(context, item, count, lst))
    memo[1] = next
    next

  reduce(lst, reducer, root, context)
  (cdr root)

rmap = (lst, iteratee, context) ->
  return nil if nilp lst
  root = cons()

  reducer = (memo, item, count) ->
    cons(iteratee.call(context, item, count, lst), memo)

  reduce(lst, reducer, root, context)

filter = (lst, iteratee, context) ->
  return nil if nilp lst
  root = cons()

  reducer = (memo, item, count) ->
    if iteratee.call(context, item, count, lst)
      next = cons(item)
      memo[1] = next
      next
    else
      memo

  reduce(lst, reducer, root, context)
  if (pairp root) then (cdr root) else root

reverse = (lst) -> reduce(lst, ((memo, value) -> cons(value, memo)), cons())

module.exports =
  reduce: reduce
  map: map
  rmap: rmap
  filter: filter
  reverse: reverse
  
