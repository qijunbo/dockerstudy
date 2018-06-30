#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
def traval(filepath):
  for fpath,dirs,fs in os.walk(filepath):
    for f in fs:
      print 'fpathe:' + fpath
      print os.path.join(fpath,f)

traval('./')   
