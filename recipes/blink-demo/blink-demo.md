
# Blink demo

This is the `Hello world` example of the hardware world. We'll write a script that blinks an LED on and off at one second intervals.



## You will need:

- An ESP8266 module [connected to your machine](/tutorials/how-to-connect-to-an-esp8266-module)
- The esp8266-cli [installed and configured](/tutorials/how-to-push-code-to-an-esp8266-module).
- An LED



## Background

If this is your first project for the ESP8266 module, it may be worth reading the following introductions to the features that we're going to use.

- [Introduction to the GPIO API](/tutorials/introduction-to-the-gpio-api)
- [Introduction to the timer API](/tutorials/introduction-to-the-timer-api)

If this is your first Lua project, it might also be worth reading the following first:

- [Lua basics](/tutorials/lua-basics)



## Wiring
We'll start by wiring it up. Connect the positive pin of an LED to GPIO2 and the negative to GND. Along with the power and comms wiring, you should have something that looks like this:

![Connecting an ESP-01 with LED on GPIO2](https://raw.githubusercontent.com/hackhitchin/esp8266-co-uk/master/images/esp-01-with-led-on-gpio2.png)

Great stuff. Time to code.



## Code
In this Lua script we'll first set up some variables with values that we want to use later. This way, if in future we want to change the pin, duration, etc. we only need to change one line.

Then we'll initialise the pin with the correct mode and give it a value.

Finally we'll create an interval at index zero. Each time the timer ticks we will toggle in the value of our `value` variable and then write its new value to the LED.

```lua
-- Config
local pin = 4			--> GPIO2
local value = gpio.LOW
local duration = 1000	--> 1 second

-- Initialise the pin
gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, value)

-- Create an interval
tmr.alarm(0, duration, 1, function ()
	if value == gpio.LOW then
		value = gpio.HIGH
	else
		value = gpio.LOW
	end

	gpio.write(pin, value)
end)
```

Save this as `init.lua`, [push it to the module](/tutorials/how-to-push-code-to-an-esp8266-module) and reset. 

Et voila.


