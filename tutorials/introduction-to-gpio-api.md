
# Introduction to the GPIO API

A GPIO (or general-purpose input/output) is a pin that can be used by our code to interface to the outside world. 
We can use a GPIO pin to listen for things, like a button press (input) or to control things, like light an LED (output).

Let's see how that's done...



## Set pin mode

When using GPIO pins we first need to specify in which mode we'd like to use it. There are three modes into which a pin can be set:

| Mode      | Reference   | Description                                                                     |
| --------- | ----------- | ------------------------------------------------------------------------------- |
| Input     | gpio.INPUT  | Poll a pin to get its value.                                                    |
| Output    | gpio.OUTPUT | Assign a pin its value.                                                         |
| Interrupt | gpio.INT    | Same as input + set a callback to be executed every time a pin's value changes. |


To set a pin to one of these modes, we use the `gpio.mode()` function:

```lua
gpio.mode(pin1, gpio.INPUT)		-- set pin1 to input mode
gpio.mode(pin2, gpio.OUTPUT)	-- set pin2 to output mode
gpio.mode(pin3, gpio.INT)		-- set pin3 to interrupt mode
```

All pretty straightforward stuff, but don't relax just yet! This is where it gets a little confusing.

You might think that the value of `pin1`, `pin2` and `pin3` are the numbers on the GPIO pins. Am I right? Yeah, I thought that too, but it's not that easy. The first argument to `gpio.mode()` (and other `gpio` functions) is actually an _IO index_.

IO indices map to the same GPIO pins on all modules, but they don't map in any particular order. Instead you'll have to memorise them all, or keep referring back to this table:

(Alternatively, you can use one of these [quick cheats to preset variables with the mapped values](https://gist.github.com/paulcuth/f646f220a617a5fe43a1).)

| GPIO pin | IO index |
| -------- | -------- |
| GPIO0    | 3        |
| GPIO1    | 10       |
| GPIO2    | 4        |
| GPIO3    | 9        |
| GPIO4    | 2        |
| GPIO5    | 1        |
| GPIO6    | N/A      |
| GPIO7    | N/A      |
| GPIO8    | N/A      |
| GPIO9    | 11       |
| GPIO10   | 12       |
| GPIO11   | N/A      |
| GPIO12   | 6        |
| GPIO13   | 7        |
| GPIO14   | 5        |
| GPIO15   | 8        |
| GPIO16   | 0        |

Therefore, if you'd like to set GPIO2 to output mode, you use this:

```lua
gpio.mode(4, gpio.OUTPUT)
```

And if you'd like to set GPIO0 to interrupt mode:

```lua
gpio.mode(3, gpio.INT)
```



## Using output mode

Next up, let's set some output pins either low (0v) or high (3.3v). To do that we use `gpio.write()`.

So, to set GPIO0 pin high and GPIO2 pin low:

```lua
gpio.mode(3, gpio.OUTPUT)
gpio.write(3, gpio.HIGH)

gpio.mode(4, gpio.OUTUT)
gpio.write(4, gpio.LOW)
```

Easy-peasy.



## Using input mode

Equally we can ask if an input pin is currently set low or high. We do that using `gpio.read()`:

Let's print the current value of GPIO2:

```lua
gpio.mode(4, gpio.INPUT)
local pinValue = gpio.read(4)

if pinValue == gpio.LOW then
	print 'GPIO2 is low'
else
	print 'GPIO2 is high'
end
```



## Using interrupt mode

If we want to know when a pin's value changes (ie. when a button is pressed) we could set the pin to input mode and keep reading its value. A better solution, however, would be to use interrupt mode. That way we can create a function and set it to be called every time the pin's value changes.

We define which callbacks are called when by using `gpio.trig()`. Let's write to the console when GPIO2 changes value:

```lua
local pin = 4	--> GPIO2

function onChange ()
	print('The pin value has changed to '..gpio.read(pin))
end

gpio.mode(pin, gpio.INT)
gpio.trig(pin, 'both', onChange)
```

The second argument to `gpio.trig()` is the name of the event to which to listen. As you can see, in the previous example we are listening for the `both` event; this occurs both when the pin moves from high to low _and_ when it moves low to high.

There are several events on a pin to which you can listen:

| Event name | Description                              |
| ---------- | ---------------------------------------- |
| up         | Occurs when the pin moves high.          |
| down       | Occurs when the pin moves low.           |
| both       | Occurs when the pin moves high or low.   |
| low        | Occurs repeatedly while the pin is low.  |
| high       | Occurs repeatedly while the pin is high. |



## Debouncing

When using hardware buttons for the first time you may notice something odd: When you press a button down the pin changes value, changes back again and finally settles on the new value once more. This is called _contact bounce_ and it is common.

The simple way to mitigate against this bounce is to ignore events for a short period of time after a change in state has occurred. This is called _debouncing_.

The following shows how you can debounce the previous example:

```lua
local pin = 4	--> GPIO2

function debounce (func)
	local last = 0
	local delay = 5000

	return function (...)
		local now = tmr.now()
		if now - last < delay then return end

		last = now
		return func(...)
	end
end

function onChange ()
	print('The pin value has changed to '..gpio.read(pin))
end

gpio.mode(pin, gpio.INT)
gpio.trig(pin, 'both', debounce(onChange))
```

The `debounce()` function takes a function as its argument and wraps it in another. When the outer function is called, that then calls the inner function, but only if it hasn't been called in the last 5000us (5ms).

You'll see this `debounce()` function popping-up in many of the examples in the [recipes](recipes) section, so it would be good to get to know it.




