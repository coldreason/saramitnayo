import gc
import time
import custom_func as cfn

CHECK_CYCLE = 1800

cfn.network_init('hands-2.4G','hands1986')
time.sleep(1)

bef = -10000
counter = 0
data = cfn.set_initialize()

while True:
    now = time.time()
    if(now > bef + CHECK_CYCLE):
        bef = now
        gc.collect()
        data = cfn.get_data(data)
        counter = 0

    if(data['forceUpdate']== True):
        gc.collect()
        cfn.update_data(data)
        data['forceUpdate'] = False
        counter = 0
    
    gc.collect()
    counter = cfn.read_data_sensor(counter,data)

    if counter == 0 or data['forceUpdate'] == True:
        time.sleep(data['interval']*15)
    else:
        time.sleep(data['interval'])

    if counter == data['count']:
        data['state'] = not data['state']
        data['forceUpdate'] = True