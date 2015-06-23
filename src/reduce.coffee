{car, cdr, cons, listp, pairp, nilp,
  nil, list, listToString} = require './lists'

reduce = (lst, iteratee, memo, context) ->
  count = 0
  console.log lst
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

map = (lst, iteratee, context, count = 0) ->
  return nil if nilp lst
  product = iteratee.call(context, (car lst), count, lst)
  rest = if (nilp cdr lst) then nil else
    map((cdr lst), iteratee, context, count + 1)
  cons product, rest

rmap = (lst, iteratee, context, count = 0) ->
  ptr = lst
  ret = cons()
  while not nilp ptr
    ret = cons (car ptr), ret
    ptr = cdr ptr
  ret

reverse = (lst) -> rmap lst, (i) -> i

filter = (lst, iteratee, context) ->
  return nil if nilp lst
  if iteratee.call(context, (car lst), lst)
    cons (car lst), (filter (cdr lst), iteratee, context)
  else
    filter (cdr lst), iteratee, context

module.exports =
  reduce: reduce
  map: map
  rmap: rmap
  filter: filter
  reverse: reverse

