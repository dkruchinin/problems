#!/bin/sh

java problem17 $(for i in `cat 18data`; do echo -n "$i "; done; echo)