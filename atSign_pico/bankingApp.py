# This is hardware part of banking app.
# It takes user's input and send it to atSign server after the authentication.

def main():
    from machine import Pin
    import utime
    import random

  
############### atSign Authentication ######################
     # read settings.json
    from lib.at_client import io_util
    ssid, psw, atSign = io_util.read_settings()
    del io_util # make space in memory

    # connect to wifi
    from lib import wifi
    print('Connecting to WiFi %s...' % ssid)
    wifi.init_wlan(ssid, psw)
    del ssid, psw, wifi # make space in memory

    # connect and pkam authenticate into secondary
    from lib.at_client import at_client
    atClient = at_client.AtClient(atSign, writeKeys=True)
    atClient.pkam_authenticate(verbose=True)
    del at_client
##############################################

    # Create a map between keypad buttons and characters
    matrix_keys = [['1', '2', '3', 'a'],
                ['4', '5', '6', 'b'],
                ['7', '8', '9', 'c'],
                ['*', '0', '#', 'd']]

    # Define PINs according to cabling, change the pins to match with your connections
    keypad_rows = [9,8,7,6]
    keypad_columns = [5,4,3,2]

    col_pins = []
    row_pins = []

    ## input entered by the user
    acc = []
    pin =[]


   
    #setup pin to be an output
    # led = Pin("LED", Pin.OUT)

    for x in range(0,4):
        row_pins.append(Pin(keypad_rows[x], Pin.OUT))
        row_pins[x].value(1)
        col_pins.append(Pin(keypad_columns[x], Pin.IN, Pin.PULL_DOWN))
        col_pins[x].value(0)
    
##############################Scan keys ####################
    
    def scankeys():
        
        for row in range(4):
            for col in range(4): 
                row_pins[row].high()
                key = None
                
                if col_pins[col].value() == 1:
                    
                    if len(pin) > 3:
                        print("Now is the acc/action, you have pressed:", matrix_keys[row][col])
                        key_press = matrix_keys[row][col]
                        utime.sleep(0.3)
                        acc.append(key_press)
                    else:
                        print("Now is the pin, you have pressed:", matrix_keys[row][col])
                        key_press = matrix_keys[row][col]
                        utime.sleep(0.3)
                        pin.append(key_press)    

                    

                # Generate random id 
                request_id = str(random.randrange(1000000,2000000)) + "e"
                # The value send to atSign
                value="".join(map(str,acc)) + request_id
                if len(acc) == 9:
                    atClient.put_public("".join(pin), value,namespace='project11')
                    
                    for x in range(0,9):
                        acc.pop() 
                        
            row_pins[row].low()
   
                

    ##########################################################
        
    print("Welcom, please enter the info: ")
    print("Remainder for the format: pin(4) + acc(9)")
    print("____ + a ___ a ___ a")


    

    while True:
        
        scankeys()


if __name__ == "__main__":
    main()