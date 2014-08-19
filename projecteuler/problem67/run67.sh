#!/bin/sh

java problem67 $(for i in `cat triangle.txt`; do echo -n "$i "; done; echo)
#for i in `cat triangle.txt`; do echo -n "$i "; done; echo