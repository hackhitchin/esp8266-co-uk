# Lua Basics

## Comments

Comments can be delimited in two ways. They may be placed between `--` and the end of the line.

```lua
print('Hello')	-- This bit here is a comment
```


Multi-line comments may be placed between `--[[` and `--]]`.

```lua
--[[
print('This code is commented out and won\'t be output')
--]]
```

The multi-line delimiters have a handy feature in that code that has been commented out can be re-introduced with a single character. 
By adding a space to the start delimiter, both delimiters become line comments.

```lua
-- [[
print('This code is no longer commented out and will be output')
--]]
```



## Variables

You can assign a value of any type to any variable.

```lua
local foo = 2
local bar = 'Hello'
```


Any variable can hold values of different types at different times.

```lua
local foo = 2
foo = 'Hello'
```


A `do` block provides scoping.

```lua
do
    local foo = 'Hello'
    print('Inside the do block, foo's value is Hello: ', foo)
end
print('Outside the do block, foo is nil: ', foo)
```


`nil` is a special value that means a variable is not defined. Setting a variable's value to `nil` deletes that variable and frees up memory, as if it never existed.

```lua
local foo = 'Hello'
foo = nil
```


## Tables

Lua has one data structure that can be used both as an array and/or as a hash: the table. Tables are defined with braces, `{}`.
An array-like table might look like this: 

```lua
local items = {}
table.insert(items, 12)
table.insert(items, 'Moo')
table.insert(items, true)

--> items == { 12, 'Moo', true }
--> items[0] == nil
--> items[1] == 12
--> items[2] == 'Moo'
--> items[3] == true
```
Did you notice? Array indices start at 1!

A hash-like table might look like this:

```lua
local animal = {}
animal.type = 'cat'
animal.name = 'Ruby'
animal.strokable = true

--> animal == { type = 'cat', name = 'Ruby', strokable = true }
```

But a table can also be both an array and a hash at the same time:

```lua
local todoList = {}
table.insert(todoList, 'Buy present')
table.insert(todoList, 'Wrap present')
todoList.deadline = '2015-12-24'

-- todoList == { 'Buy present', 'Wrap present', deadline = '2015-12-24' }
```

The `#` operator returns the number of items in the array-part of a table.

```lua
local items = { 'A', 'B', 'C', foo = 'bar' }
print(#items)	--> 3
```


## Functions

Code that is used often can be placed in functions.

```lua
function sayHello (recipient)
	print('Hello, '..recipient)
end

sayHello('Roberto')
sayHello('Luiz')
sayHello('Waldemar')

```


A function may return multiple values.

```lua
function getCoordinates ()
	return 12, 55, 123
end

local x, y, z = getCoordinates()
print(x, y, z)	--> 12  55  123
```


## Control structures


### `if` `then` `else`

You can execute a statement if a particular condition is met.

```lua
if kittenCount > 0 then 
    print('You have kitten(s)')
end
```


You may also branch the execution into many paths.

```lua
if kittenCount == 0 then 
    print('You have no kittens') 
elseif kittenCount == 1 then 
    print('You have a kitten') 
else
    print('You have many kittens') 
end
```

#### Negation

Conditions can be negated using `not`:

```lua
if not isLoggedIn then
	return 'guest'
end
```

Watch out for the uncommon "not equal" operator, `~=`.

```lua
if kittenCount ~= 0 then
	print('You have kittens!')
end
```


#### Coercing to boolean

When coercing a value of another type to a boolean, the only value that coerces to `false` is `nil`; any other value coerces to `true`.

```lua
if 0 then
	print('Zero coerces to true')
end

if '' then
	print('Empty strings coerce to true')
end

if {} then
	print('Empty tables coerce to true')
end

if nil then
	-- This will never run
end
```



### `while`

You can loop while a condition is met before each iteration.

```lua
local kittens = { 'Mr Tibbs', 'Tufty', 'Kipper' }

while #kittens > 0 do
    local kitten = table.remove(kittens, 1)
    print(kitten)
end
```


### `repeat until`

You can also loop until a condition is met after an iteration.

```lua
local kittens = { 'Mr Tibbs', 'Tufty', 'Kipper' }

repeat 
    local kitten = table.remove(kittens, 1)
    print(kitten)
until #kittens == 0 
```



### Numeric `for`

There are two types of `for` loop, numeric and generic. The simpler of the two is the numeric `for`:

```lua
for i = 1, 10 do            -- count up
    print(i..' banana')
end

for i = 10, 1, -1 do        -- count down
    print(i..' green bottles')
end

print('i only exists inside the loop, is now nil: ', i)
```


### Generic `for`

You can also use an iterator function, such as `ipairs()` or `pairs()`, to inject values into a loop.
`ipairs()` only iterates over the array-part of a table.

```lua
local random = { 'boot', foo = 'bar', 22 }

for key, val in ipairs(random) do
    print(key, val) 
end

--> 1	boot
--> 2	22
```

`pairs()` iterates over all properties of a table.

```lua
local random = { 'boot', foo = 'bar', 22 }

for key, val in pairs(random) do
    print(key, val) 
end

--> 1	boot
--> 2	22
--> foo	bar
```

## Tips and tricks

### Function calls don't always need parentheses

If you are passing a single string literal or a single table literal to a function, you do not need to use parentheses.

```lua
print 'Hello, world.'

setStyle{
	fontFamily = 'Helvetica',
	fontSize = 18
    color = 0xffffff
}
```

### Ternary operations

There is no ternary operator in Lua, but it is common to use boolean operators instead.

```lua
print(foo == nil and 'undefined' or foo)
```

### Unused return values

It is common practice to use an underscore to represent a return value that you do not intend to use.

```lua
for _, value in ipairs(items) do
	print(value)
end

local _, _, zPosition = getCoordinates()
```

### Spell it correctly

From [Lua.org](http://www.lua.org/about.html#name):

> "Lua" (pronounced LOO-ah) means "Moon" in Portuguese. As such, it is neither an acronym nor an abbreviation, but a noun. More specifically, "Lua" is a name, the name of the Earth's moon and the name of the language. Like most names, it should be written in lower case with an initial capital, that is, "Lua". Please do not write it as "LUA", which is both ugly and confusing, because then it becomes an acronym with [different meanings](http://acronyms.thefreedictionary.com/lua) for different people. So, please, write "Lua" right! 


## What next?

* Try out some of the [recipes](/recipes).
