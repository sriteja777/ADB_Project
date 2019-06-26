import os
import sys
from subprocess import call
import events
from adb.client import Client as AdbClient

SCRIPTS_DIR = './scripts/'
UNLOCK_SCRIPT = SCRIPTS_DIR + 'unlock_phone.sh'
PROPERTIES_SCRIPT = SCRIPTS_DIR + 'get_device_properties.sh'
SIZE_SCRIPT = SCRIPTS_DIR + 'get_screen_size.sh'
TYPE_SCRIPT = SCRIPTS_DIR + 'type.sh'
SYNC_SCRIPT = SCRIPTS_DIR + 'sync_contacts.sh'

if len(sys.argv) < 2:
    print("Usage: python3 main.py [commands] [flags]")
    exit(1)

arg = sys.argv[1]


client = AdbClient(host="127.0.0.1", port=5037)
devices = client.devices()
if len(devices) == 0:
    print("No devices found")

device = devices[0]

if arg == "unlock":
    call(UNLOCK_SCRIPT)
elif arg == "properties":
    call(PROPERTIES_SCRIPT)
elif arg == "size":
    out = os.popen(SIZE_SCRIPT).read().split()
    fmt = '{:<6} {:<2} {:<5}'
    print(fmt.format('Width', ':', out[0]))
    print(fmt.format('Height', ':', out[1]))
elif arg == "type":
    print("Type :")
    call(TYPE_SCRIPT)
elif arg == "sync":
    call(SYNC_SCRIPT)
elif arg == "record":
    events.record_event(device)
elif arg == "play":
    events.play_event(device)

