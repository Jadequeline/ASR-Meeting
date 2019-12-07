#!/usr/bin/env python
# coding=utf-8

import os
import sys
import fileinput
import re
from fnmatch import fnmatch


root      = sys.argv[1]
f_output = open(sys.argv[2], "w", encoding="utf-8")
pattern   = "*.wav"
number = {
    0: "",
    1: "",
    2: "",
    3: "",
    4: "",
    5: "",
    6: "",
    7: "",
    8: "",
    9: ""
}

for path, subdirs, files in os.walk(root):
    for name in files:
        if fnmatch(name, pattern):
            f_output.write(name.replace(".wav", " ").replace("\\", "/"))
            for i in range(0, 10):
                if fnmatch(name, "*0" + str(i) + ".wav"):
                    f_output.write(number[i] + " ")
            f_output.write("\n")
