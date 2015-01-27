-- Config
local pin = 4			--> GPIO2
local value = gpio.LOW
local duration = 1000	--> 1 second


-- Function toggles LED state
function toggleLED ()
	if value == gpio.LOW then
		value = gpio.HIGH
	else
		value = gpio.LOW
	end

	gpio.write(pin, value)
end


-- Initialise the pin
gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, value)


-- Create an interval
tmr.alarm(0, duration, 1, toggleLED)
