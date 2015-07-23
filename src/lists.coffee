vectorp = (a) -> toString.call(a) == '[object Array]'

cellp = (a) -> vectorp(a) and a.__type == 'list'

pairp = (a) -> cellp(a) and (a.length == 2)

listp = (a) -> (pairp a) and (pairp cdr a)

recordp = (a) -> Object.prototype.toString.call(a) == '[object Object]'

nilp = (a) -> cellp(a) and a.length == 0

makeAsCell = (l) ->
  Object.defineProperty l, '__type',
    value: 'list'
    configurable: false
    enumerable: false
    writable: false
  l

nil = (-> makeAsCell([]))()

cons = (a, b = nil) ->
  return nil if (nilp a) and (nilp b)
  makeAsCell if (not (a?)) then b else [a, b]

car = (a) -> a[0]

cdr = (a) -> a[1]

vectorToList = (v, p) ->
  p = if p? then p else 0
  if p >= v.length then return nil
  # Annoying, but since lists are represented as nested arrays, they
  # have to be intercepted first.  The use of duck-typing here is
  # frustrating.
  item = if pairp(v[p]) then v[p] else
    if vectorp(v[p]) then vectorToList(v[p]) else v[p]
  cons(item, vectorToList(v, p + 1))

list = (v...) ->
  ln = v.length
  (nl = (a) ->
    cons(v[a], if (a < ln) then (nl(a + 1)) else nil))(0)

listToVector = (l, v = []) ->
  return v if nilp l
  v.push if pairp (car l) then listToVector(car l) else (car l)
  listToVector (cdr l), v

metacadr = (m) ->
  ops = {'a': car, 'd': cdr}
  seq = vectorToList m.match(/c([ad]+)r/)[1].split('').reverse()
  return (l) ->
    inner = (l, s) ->
      return l if (nilp l) or (nilp s)
      inner ops[(car s)](l), (cdr s)
    inner l, seq

module.exports =
  cons: cons
  nil: nil
  car: car
  cdr: cdr
  list: list
  nilp: nilp
  cellp: cellp
  pairp: pairp
  listp: listp
  vectorToList: vectorToList
  listToVector: listToVector
  setcar: (a, l) -> l[0] = a; a
  setcdr: (a, l) -> l[1] = a; a
  cadr: (l) -> car (cdr l)
  cddr: (l) -> cdr (cdr l)
  cdar: (l) -> cdr (car l)
  caar: (l) -> car (car l)
  caddr: (l) -> car (cdr (cdr l))
  cdddr: (l) -> cdr (cdr (cdr l))
  cadar: (l) -> car (cdr (car l))
  cddar: (l) -> cdr (cdr (car l))
  caadr: (l) -> car (car (cdr l))
  cdadr: (l) -> cdr (car (cdr l))
  metacadr: metacadr
