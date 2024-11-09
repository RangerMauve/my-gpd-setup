#!/bin/bash

# Check if the nerd-dictation process is running
if pgrep -f nerd-dictation > /dev/null; then
    nerd-dictation end
else
    nerd-dictation begin \
      --numbers-as-digits \
      --numbers-no-suffix \
      --timeout 20 \
      --idle-time 0.5 \
      --punctuate-from-previous-timeout 0.5 \
      --simulate-input-tool=DOTOOL &
fi
