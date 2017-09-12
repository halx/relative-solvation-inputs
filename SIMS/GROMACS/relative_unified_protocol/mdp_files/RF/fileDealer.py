#!/usr/bin/env python

#enlarge the number of run files to an ideal number
import fileManager as tool

tool.CopyMDP(16)
tool.CreateRunningScripts("run",16)
tool.FixLambdasAndNames('rel')
