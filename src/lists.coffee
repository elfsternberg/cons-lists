
# This is very clever.  Most people don't know that if you return a
# valid object in a constructor, it becomes the new object rather than
# the 'this' of the constructor, as most people expect.  The biggest
# problem with this method is that you can't use instanceof; this
# method preserves the Array signature.  It is a way of "getting
# around" the Array decoration problem, but it's not perfect.

ConsList = ->
  list = Object.create(Array::)
  list = Array.apply(list, arguments) || list;
  for field of ConsList::
    list[field] = ConsList::[field]
  Object.defineProperty list, 'isList',
    value: true,
    configurable: false,
    enumerable: false,
    writeable: false
  Object.defineProperty list, 'toString',
    value: ->
      helper = (node) ->
        return "" if node.length == 0
        return node[0].toString() if node.length == 1
        return node[0].toString() + " . " + node[1].toString() if not node[1].isList
        return node[0].toString() if node[1].length == 0
        return node[0].toString() + " " + helper(node[1])
      '(' + helper(this) + ')'
    configurable: false,
    enumerable: false,
    writeable: false
  list

_annotate = (ConsList) ->
  nilp = (c) -> !!c.isList and c.length == 0
  
  cons = (a = nil, b = nil) ->
    return (new ConsList()) if (nilp a) and (nilp b)
    if (a?) then (new ConsList(a, b)) else (new ConsList(b))
  
  nil = (-> new ConsList())()
  
  vectorp = (c) -> toString.call(c) == '[object Array]'
  cellp = (c) -> !!c.isList
  pairp = (c) -> !!c.isList and (c.length == 2)
  listp = (c) -> !!c.isList and (c.length == 2) and (cellp cdr c)
  recordp = (c) -> Object.prototype.toString.call(c) == '[object Object]'
  
  car = (c) -> c[0]
  cdr = (c) -> c[1]
  
  vectorToList = (v, p, d = true) ->
    p = if p? then p else 0
    if p >= v.length then return nil
    # Annoying, but since lists are represented as nested arrays, they
    # have to be intercepted first.  The use of duck-typing here is
    # frustrating.
    item = if pairp(v[p]) then v[p] else
      if (d and vectorp(v[p])) then vectorToList(v[p], 0, d) else v[p]
    cons(item, vectorToList(v, p + 1, d))

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

  {
    List: ConsList
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
  }

_export = _annotate(ConsList)
Object.defineProperty _export, '_annotate',
    value: _annotate
    configurable: false,
    enumerable: false,
    writeable: false

module.exports = _export
