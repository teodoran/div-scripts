#!/usr/bin/env python
# -*- coding: utf-8 -*-

from random import randint
import sys

reload(sys)
sys.setdefaultencoding('utf-8')

alphabeth = 'ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ .'.decode('utf8')
columns = 300
rows = 5000

for row in range(0, rows):
    key_row = ''
    for digit in range(0, columns):
        if digit > 0 and digit % 6 == 0:
            key_row += '-'
        key_row += alphabeth[randint(0, len(alphabeth) - 1)]
    print key_row