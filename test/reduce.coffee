chai = require 'chai'
chai.should()
expect = chai.expect 

{listToVector, vectorToList, listToString, cons, list, nil} = require '../src/lists'
{map, reduce, filter, reverse} = require '../src/reduce'

id = (item) -> item
  
describe 'Map Identity Testing', ->

  samples = [
    cons(),
    cons(nil),
    cons('a'),
    cons('a', cons('b'))
    cons('a', cons('b', cons('c'))),
    cons('a', cons('b', cons('c'), nil))]
    
  for t in samples
    do (t) ->
      it "should produce the same thing as #{t}", ->
        product = map(t, id)
        expect(product).to.deep.equal(t)    

describe 'Filter Testing Testing', ->

  samples = [
    [vectorToList([]), nil],
    [vectorToList([1]), nil],
    [vectorToList([1, 2]), cons(2)],
    [vectorToList([1, 2, 3]), cons(2)],
    [vectorToList([1, 2, 3 ,4]), cons(2, cons(4))]]

  truth = (item) -> item % 2 == 0
            
  for [t, v] in samples
    do (t, v) ->
      it "should produce the same thing as #{v}", ->
        product = filter(t, truth)
        expect(product).to.deep.equal(v)    

describe 'Reverse', ->

  samples = [
    [cons(), cons()]
    [cons(nil), cons(nil)]
    [cons('a'), cons('a')]
    [cons('a', cons('b')), cons('b', cons('a'))]
    [cons('a', cons('b', cons('c'))), cons('c', cons('b', cons('a')))]]

  for [t, v] in samples
    do (t, v) ->
      it "#{t} should produce a reverse of #{v}", ->
        product = reverse(t)
        expect(product).to.deep.equal(v)
