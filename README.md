*tl;dr*

This is a dead-simple setmetatable() wrapper. It injects a newproxy() key directly into objects.
So be careful if you use pairs().

*still reading?*

when caching your smt() call:

`local setmetatable = require '__gc'`

If your version of Lua actually supports __gc on tables, the above call simply returns the original `setmetatable`.

Normally, you'd use the above only in files which actually need tables with finalizers. But if you feel more adventurous,
you can also override globally:

`setmetatable = require '__gc'`

The semantics are then exact same as in Lua 5.3 - finalizers are called when last reference to the table is lost,
and re-animating zombie objects works as well (effectively cancelling the gc) - if you call setmetatable() on the object
again within the finalizer.

All objects you set a metatable on through this wrapper get "polluted" with special key `__gc_proxy` (can be any string,
user definable through __GC_PROXY global). You'll have to special-case it if you iterate over the fields of
tables (next(), pairs() ...).

The keys appear to be unavoidable, various combinations of using weak tables by the side don't seem to work as expected.

The overhead of newproxy() machinery is there only if you actually set the __gc field, otherwise the initial smt() is just a bit slower,
with no gc/runtime overhead.
