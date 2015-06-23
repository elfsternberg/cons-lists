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
  return nil if nilp lst
  product = (if (nilp cdr lst) then nil else
    map((cdr lst), iteratee, context, count + 1))
  cons product, iteratee.call(context, (car lst), count, lst)

filter = (lst, iteratee, context) ->
  return nil if nilp lst
  if iteratee.call(context, (car lst), lst)
    cons (car lst), filter (cdr lst)
  else
    filter (cdr list)

reverse = (lst) -> rmap lst, (i) -> i

module.exports =
  reduce: reduce
  map: map
  rmap: rmap
  filter: filter
  reverse: reverse

