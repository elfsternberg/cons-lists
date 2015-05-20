{listToString, listToVector, pairp, cons, car, cdr, caar, cddr, cdar, cadr, caadr, cadar, caddr, nilp, nil, setcdr, metacadr} = require "cons-lists/lists"

evlis = (exps, d) ->
  if (pairp exps) then evaluate((car exps), d) + " " + evlis((cdr exps), d) else evaluate(exps, d)

indent = (d) ->
  ([0..d].map () -> " ").join('')
    
evaluate = (e, d = 0) ->
  t = typeof e
  if (pairp e) then "\n" + indent(d) + "(" + evlis(e, d + 2) + ")"
  else if (nilp e) then "()"
  else if t is "boolean" then (if e then "#t" else "#f")
  else if t is "string"
    if e.length > 0 and e[0] == '"' then '"' + e + '"' else e
  else if t is "number" then e
  else if t is "function" then e.toString()
  else e.toString()
    
module.exports = (c) -> evaluate c, 0
