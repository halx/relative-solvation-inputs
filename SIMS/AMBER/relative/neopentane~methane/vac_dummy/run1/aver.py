import sys

n=0
av=0.0

with open(sys.argv[1], 'r') as log:
  for line in log:
    if line.startswith('Result'):
      _, d = line.split()
      av += float(d)
      n += 1

print av/n
