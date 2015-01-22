
# Introduction to the GPIO API

A GPIO (or general-purpose input/output) is a pin that can be used by our code to interface to the outside world. 
We can use a GPIO pin to listen for things, like a button press (input) or to control things, like light an LED (output).

Let's see how that's done...



## Set pin mode

As with other hardware platforms, when using GPIO pins we first need to specify in which mode we'd like to use it: input or output. To do that, we use the `gpio.mode()` function.

```lua
gpio.mode(pin1, gpio.OUTPUT)	-- set pin1 to output mode
gpio.mode(pin2, gpio.INPUT)		-- set pin2 to input mode
```

All pretty straightforward stuff, but don't relax just yet! This is where it gets a little confusing.

You might think that the value of `pin1` and `pin2` are the numbers on the GPIO pins. Am I right? Yeah, me too, but that's too easy. These values are actually _IO indices_.

IO indices map to the same GPIO pins on all modules, but they don't go up in any linear fashion. Instead you'll have to memorise them all, or keep referring back to this table:

(Alternatively, you can use this [quick cheat to preset variables with these mapped values](https://gist.github.com/paulcuth/f646f220a617a5fe43a1).)

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

And if you'd like to set GPIO0 to input mode:

```lua
gpio.mode(3, gpio.INPUT)
```



## Using output pins

Next up, let's set some output pins to either low (0v) or high (3.3v). To do that we use `gpio.write()`.

So, to set GPIO0 pin high and GPIO2 pin low:

```lua
gpio.write(3, gpio.HIGH)
gpio.write(4, gpio.LOW)
```

Easy-peasy.




## Using input pins

Equally we can ask if an input pin is current set low or high. We can do that using `gpio.read()`:

Let's print the current value of GPIO2:

```lua
local pinValue = gpio.read(4)

if pinValue == gpio.LOW then
	print 'GPIO2 is low'
else
	print 'GPIO2 is high'
end
```

