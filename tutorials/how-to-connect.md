
# How to connect to an ESP8266 module


## You will need:

- ESP8266 module.
- USB to serial UART adapter, for instance an [FT232RL board](/shop/ft232rl-usb-to-serial-uart-adapter).
- USB to micro USB cable.
- Female-to-female dupont wires or other connectors.


## Layout

Connect the pins on the adapter to those on the module in the following configuration, then connect the adapter to your machine with the USB cable.

| USB to serial adapter | ESP-xx module |
| --------------------- | ------------- |
| VCC(3.3v)             | VCC, CH_PD    |
| GND                   | GND           |
| Tx                    | Rx            |
| Rx                    | Tx            |

### Important: 
Your adapter may have two VCC pins (3.3v and 5v) or a single VCC pin and a jumper to switch between the two voltages. **You should use the 3.3v option.** If you accidently connect your module at 5v, don't worry too much; you can [buy more modules in our shop](/shop).

### ESP-01
![Connections for ESP-01 module](https://raw.githubusercontent.com/hackhitchin/esp8266-co-uk/master/images/esp-01-connections.png)

## Communicating

Once your module is connected and plugged into your machine, you should be able to communicate with module using a serial terminal.

Your serial terminal application should be configured with the following settings:

- Baud rate: 9600
- Data bits: 8
- Stop bits: 1
- Parity: none


## Testing

If you have Lua firmware installed on the module and the module is correctly connected and the software setup correctly, you should see the characters that you type in the terminal echoed back to you. 

If this is the case, what you are actually doing here is talking to the Lua REPL (read-eval-print loop) on the module. Try typing the following, followed by enter:

```lua
print 'hello'
```

You should see `hello` appear on the line below. If you do, you're connected. 

