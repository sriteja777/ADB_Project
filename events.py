import signal

from adb.client import Client as AdbClient

event = ""
cmd = ""


def generate_cmd():
    global cmd
    lines = event.split('\n')
    for line in lines:

        if not line:
            continue

        num = line.split(' ')
        cmd += 'sendevent /dev/input/event1 '
        for i in range(len(num)):
            num[i] = int(num[i], 16)
            cmd += str(num[i]) + ' '
        cmd += '; '


def write_cmd(filepath):
    with open(filepath, 'w') as f:
        f.write(cmd)


def play_event(device, file):
    device.push(file, "/data/local/tmp/cmd.sh")
    device.shell("sh /data/local/tmp/cmd.sh")


def sig_handler(signum, frame):
    print("Forever is over!")
    raise Exception("end of time")


def event_handler(connection):
    global event
    while True:
        data = connection.read(1024)
        if not data:
            break
        event += data.decode('utf-8')
    connection.close()


def record_event(device, filepath, timeout=5):
    global event, cmd
    event = ""
    cmd = ""
    signal.alarm(timeout)
    try:
        k = device.shell("getevent /dev/input/event1", handler=event_handler)
    except:
        pass

    print("Event recorded")
    # print(event)
    generate_cmd()
    # print(cmd)
    write_cmd(filepath)

signal.signal(signal.SIGALRM, handler=sig_handler)
if __name__ == "__main__":
    client = AdbClient(host="127.0.0.1", port=5037)

    print(client.version())

    device = client.device("10.42.0.231:5555")
    signal.signal(signal.SIGALRM, handler=sig_handler)
    record_event(device, "cmd.sh")
    play_event(device, "cmd.sh")

# print(event)
