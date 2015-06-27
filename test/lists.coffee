chai = require 'chai'
chai.should()
expect = chai.expect

{listToVector, vectorToList, cons, list, nil,
  metacadr, car, cdr, cadr} = require '../src/lists'

describe "Basic list building", ->
  for [t, v] in [
    [cons(), cons()]
    [cons(nil), cons(nil)]
    [cons('a'), cons('a')]
    [cons('a', cons('b', cons('c'))), cons('a', cons('b', cons('c')))]
    [cons('a', cons('b', cons('c'))), cons('a', cons('b', cons('c', nil)))]
    [cons('a', cons('b', cons('c', nil))), cons('a', cons('b', cons('c')))]]
    do (t, v) ->
      it "should match #{t}", ->
        expect(t).to.deep.equal(v)

mcsimple = cons('a', cons('b', cons('c')))

describe "Basic list traversing", ->
  it "should car", ->
    expect(car mcsimple).to.equal("a")
  it "should cadr", ->
    expect(cadr mcsimple).to.equal("b")
  it "should car cdr cdr", ->
    expect(car cdr cdr mcsimple).to.equal("c")

describe 'Round trip equivalence', ->
  for [t, v] in [
    [[], []]
    [['a'], ['a']]
    [['a', 'b'], ['a', 'b']]
    [['a', 'b', 'c'], ['a', 'b', 'c']]]
    do (t, v) ->
      it "should successfully round-trip #{t}", ->
        expect(listToVector vectorToList t).to.deep.equal(v)

describe 'List Building', ->
  for [t, v] in [
    [cons(), []]
    [cons(nil), [nil]]
    [cons('a'), ['a']]
    [cons('a', cons('b')), ['a', 'b']]
    [cons('a', cons('b', cons('c'))), ['a', 'b', 'c']]
    [cons('a', cons('b', cons('c'), nil)), ['a', 'b', 'c']]]
    do (t, v) ->
      it "should cons a list into #{v}", ->
        expect(listToVector t).to.deep.equal(v)

describe 'Dynamic list constructor', ->
  for [t, v] in [
    [list(), []]
    [list('a'), ['a']]
    [list('a', 'b'), ['a', 'b']]
    [list('a', 'b', 'c'), ['a', 'b', 'c']]]
    do (t, v) ->
      it "should round trip list arguments into #{v}", ->
        expect(listToVector t).to.deep.equal(v)

mcsimple = cons('a', cons('b', cons('c')))

describe 'Metacadr Simple', ->
  for [t, v, r] in [
    ['car', 'a']
    ['cadr', 'b']
    ['caddr', 'c']]
    do (t, v) ->
      it "The #{t} should read #{v}", ->
        expect(metacadr(t)(mcsimple)).to.equal(v)

mccomplex = vectorToList([
  ['a', 'b', 'c'],
  ['1', '2', '3'],
  ['X', 'Y', 'Z'],
  ['f', 'g', 'h']])

describe 'Metacadr Complex', ->
  for [t, v, r] in [
    ['cadar', 'b']
    ['caadddr', 'f']
    ['caadr', '1']
    ['caaddr', 'X']]
    do (t, v) ->
      it "The #{t} should read #{v}", ->
        mcadr = metacadr(t)
        expect(mcadr mccomplex).to.equal(v)
        expect(mcadr mccomplex).to.equal(v)
        expect(mcadr mccomplex).to.equal(v)
