# eyesaver
Eyesaver uses ddc to adjust the colour temperature of your monitor according to the time of day. It's like redshift, but uses ddc.

You will have to edit the ddcutil commands to address your monitors specifically.
Unfortunately, this is hard to automate cleanly because the ddc implementations vary accross monitors.

To use `ddcutil` with `sudo` without a password, add

    <username> ALL = (root) NOPASSWD: /usr/bin/ddcutil *

to the end of /etc/sudoers, replacing <username with your username>
