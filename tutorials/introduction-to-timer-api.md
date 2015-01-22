# Introduction to the timer API

The Lua firmware provides an API with which you can set timeouts and intervals, functions that execute after a period of time, either once or over and over again.

However, the modules only have capacity to have seven timers or intervals running at the same time. Therefore, you need to reference them by index (0 to 6) and make sure that different parts of your program don't overwrite the same timer.


# Create a timer

We use the same function to create both timeouts and intervals, `tmr.alarm()`. We differentiate which type of timer we want to create using the third argument; `0` = timeout, `1` = interval:

`tmr.alarm(index, ms, type, callback)`

### Timeout

Let's dive into an example:

```lua
function sayHello ()
	print 'Hello'
end

tmr.alarm(0, 2500, 0, sayHello)
```

Here we are creating a timeout at timer index zero and setting it to call the `sayHello()` function after 2.5 seconds.

If we were to create another timeout (or interval) at timer index zero before this timer executes, it would simply overwrite this one and `sayHello()` would never be called.

### Interval
Another example now and this time we'll create an interval at timer index six. Notice that we can use anonymous inline functions too.

```lua
tmr.alarm(6, 5000, 1, function ()
	print 'Are we there yet?'
end)
```


# Stop a timer

Once a timer has been created, it starts ticking immediately. To stop a timeout or interval, we simply use the `tmr.stop()` function, passing the timer index as an argument.

If we wanted to stop the interval that we created in the previous example, we'd stop the timer at index six:

```lua
tmr.stop(6)
```


