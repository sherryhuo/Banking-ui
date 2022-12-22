def main():
    from machine import Pin
  
############### atSign ######################
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

    #Follow the same format to send data over to atSign server 
    # acc2: key
    # value: a100a550a100001e 
    # a100a500a:account/action | 100001:random id | e: a char "e"
    # atClient.put_public('acc2', "a100a550a100001e",namespace='project11')


##############################################
        
if __name__ == "__main__":
    main()