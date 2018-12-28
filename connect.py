from adb import adb_commands, sign_m2crypto


signer = sign_m2crypto.M2CryptoSigner('/home/sriteja/.android/adbkey')
device = adb_commands.AdbCommands()

device.ConnectDevice(rsa_keys=[signer])
# for i in range(10):
#   print(device.Shell('echo %d' % i))