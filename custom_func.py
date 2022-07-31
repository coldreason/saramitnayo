def network_init(ap,pwd):
    import network
    sta_if = network.WLAN(network.STA_IF)
    sta_if.active(True)
    sta_if.connect(ap,pwd)

def set_initialize():
    import custom_http as ch
    import json
    url = 'https://us-central1-handssilesaramitnayo.cloudfunctions.net/initialize'
    ret = ch.custom_https_get(url)
    data = json.loads(ret.decode())
    data['forceUpdate'] = False
    return data

def get_data(data):
    import custom_http as ch
    import json
    url = 'https://us-central1-handssilesaramitnayo.cloudfunctions.net/check'
    ret = ch.custom_https_get(url)
    dict = json.loads(ret.decode())
    data['state'] = dict['state']
    if(dict['forceUpdate'] == True):
        data['forceUpdate'] = True
    return data

def update_data(data):
    import custom_http as ch
    import json
    url = 'https://us-central1-handssilesaramitnayo.cloudfunctions.net/update'
    msg = {"state":data['state']}
    msg = json.dumps(msg)
    ch.custom_https_get(url,data=msg)

def read_data_sensor(counter,data):
    from machine import ADC
    from machine import Pin

    led = Pin(23, Pin.OUT)
    sensor = Pin(32, Pin.IN)
    adc = ADC(sensor)        # create an ADC object acting on a pin
    val = adc.read_u16()
    
    if(val>data['threshhold']):
        led.on()
        if data['state'] == False:
            counter = counter + 1
        else:
            counter = 0
    else:
        led.off()
        if data['state'] == True:
            counter = counter + 1
        else:
            counter = 0
    return counter