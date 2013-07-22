#!/bin/bash
gpg --keyserver keys.gnupg.net --recv-keys F8C1CA08A57B9ED7
gpg --armor --export F8C1CA08A57B9ED7 | apt-key add -
echo 'deb http://labs.consol.de/OMD/debian wheezy main' >> /etc/apt/sources.list
