
# How to push code to an ESP8266 module


## You will need:

- An ESP8266 module [connected to your machine](./how-to-connect-an-esp8266-module)
- [Node.js](htttp://nodejs.org/) installed.


## Install & configure the command line interface (CLI)
First, we need to install the tool that we'll use to upload our code to the module. We'll be using npm to install it, which comes packaged with Node.js.

Open a terminal window and enter the following at the prompt:

```
$ npm install -g esp8266
```

Now you'll be able to use the `esp` command to perform tasks on a connected ESP8266 module. To see the full list of its features, check out the [esp8266-cli readme](https://github.com/paulcuth/esp8266-cli) on GitHub.

Before you start using it, however, you will need to tell it the name of the port that you are using. This process differs depending on which platform you are using.

### Windows

If you are using a Windows machine, you can use the following link to find which comm port you are using to communicate with the module.

- [What Com Port is my USB-RS232 adaptor using?](http://www.syringepumppro.com/faq/39-connecting-pumps/79-what-com-port-is-my-usb-rs232-adaptor-using.html) (start from the second paragraph)

Once you know which comm port, enter the following into your terminal window (replacing `COM6` with your comm port):

```
$ esp port set COM6
```

### Mac / Linux

You can determine the name of the port that your adapter is using by unplugging the device, listing the ports, plugging the device back in and listing the ports again, taking note of the port that only appeared in the list the second time around.

List the current ports by entering the following into your termainal window:

```
$ ls /dev/tty.*
```

Once you know the port name, enter the following into your terminal window (replacing `/dev/tty.usbserial-A603UC7E` with your  port address):

```
$ esp port set /dev/tty.usbserial-A603UC7E
```


## Push some code

We are going to use the [blink example from the recipes section](/recipes/blink-demo) as an example script to run on the module. So, wire up an LED to the module as shown in the recipe and paste the following Lua code into a file called `blink.lua`:

```lua
-- Config
local pin = 4            --> GPIO2
local value = gpio.LOW
local duration = 1000    --> 1 second

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

Use a terminal window to navigate to the directory in which you saved `blink.lua`. You can now push this file to the module using the following command:

```
$ esp file write blink.lua
```

Your script is now on the module. To prove it, you can list the files that are currently stored in its file system:

```
$ esp file list
    258 bytes  blink.lua
```

There it is! Now run it by entering the following:

```
$ esp file execute blink.lua
```

Your LED should now be happily blinking away.


## Run a script automatically on power-up

This is simple. The Lua firmware looks for a file called `init.lua` and, if it exists, runs it.

Let's push our script again but call it `init.lua` on the module:

```
$ esp file write blink.lua init.lua
```

That extra filename on the end dictates what the file is called on the module. The previous example didn't have it, so defaulted to the same name as on your machine.

Let's see if it starts automatically:

```
$ esp restart
```

Hopefully, after a brief pause while the module reboots, the LED should start blinking again.

Now you've got the hang of it, why not try out some of the other [recipes](/recipes)?



## Notes on the file system

One thing to note is that the file system on the Lua firmware is very basic. There are no directories and every file resides the root path.

Also bear in mind that space is limited and trying to push a file that is bigger than the space available will simply crash the firmware and the module will reboot. Lua compression tools may be needed if your project is complex.
