# A javascript implementation of Lisp-like cons(), using vectors<sup>1</sup>

<sup>1</sup>Technically, coffeescript...

## Purpose

I kinda got tired of my broken list implementations that I was working
with in each and every variant of Lisp I wrote while working my way
through List In Small Pieces, so I decided to break it out into its own
managed repo.

## API

A cons is a singly-link list consisting of *pairs*, two-position
objects.  In a true cons *list*, the leftmost cell (the "car")
contains a data object of interest, and the rightmost cell (the "cdr")
contains a pointer to the next pair.  Cons lists traditionally end
with a cdr object pointing to an empty list.  The following functions
are provided to create, identify, traverse, and modify cons lists.

nil: An empty list, used as a static sentinel

cons(): Construct an empty list

cons(obj): Create a new list of one object

cons(obj, lst): Append an object to the head of an existing list

car(lst): Return the contents of the current cell, or nil.

cdr(lst): Return a reference to the next item in the list, or nil.

nilp(lst): (Boolean) is list an empty list?

pairp(obj): (Boolean) is this a object a pair?

listp(obj): (Boolean) is this object a list?

list(a, b, ...): Construct a list out of the arguments

vectorToList(v): Return a cons list given a vector. Recursive: if a
vector is encountered inside v, it will be converted to a cons list.

listToVector(l): Return a vector given a cons list.  Recursive: if
car(l) is itself a cons list, the returned vector will contain an
internal vector at that position.

setcar(obj, l): Replace the contents of car(l) with obj

setcdr(obj, l): Replace the contents of cdr(l) with obj

cadr(lst), cddr(lst), cdar(lst), caar(lst), caddr(lst), cdddr(lst), 
cadar(lst), cddar(lst), caadr(lst), cdadr(lst): Common
lisp functions that extend standard list addressing.  

metacadr(string): For more complex addressing, metacadr() can be
provided with a string that describes the address desired, and returns
the qualifying function.  For example, this library does not provide
caddddr(), but it can easily be generated: metacadr("caddddr") will
return a function to get the data content of the fifth cell.

## LICENSE AND COPYRIGHT NOTICE: NO WARRANTY GRANTED OR IMPLIED

Copyright (c) 2015 Elf M. Sternberg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

- Elf M. Sternberg <elf@pendorwright.com>
