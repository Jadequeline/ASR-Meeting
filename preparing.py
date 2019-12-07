import subprocess
import os
import sys
import locale

locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')
locale.setlocale(locale.LC_CTYPE, 'en_US.UTF-8')
subprocess.call("./2_train_htk.sh")
