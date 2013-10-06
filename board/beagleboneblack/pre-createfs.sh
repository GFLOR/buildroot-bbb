#!/bin/sh

#
# Pre create filesystem hook
#  - Prune out files that we don't need

TARGETDIR=$1

# All of the Erlang libraries get included from
# the release, so we don't need anything in here.
#rm -fr $TARGETDIR/usr/lib/erlang/lib/*

# Clean up the release
find $TARGETDIR/srv/erlang -name "*~" -exec rm "{}" ";"
find $TARGETDIR/srv/erlang -name "src" -exec rm -fr "{}" ";"
find $TARGETDIR/srv/erlang -name "include" -exec rm -fr "{}" ";"
find $TARGETDIR/srv/erlang -name "obj" -exec rm -fr "{}" ";"
rm -fr $TARGETDIR/srv/erlang/bin srv/erlang/erts-*

# Fix up multilib
if [ -d $TARGETDIR/lib/arm-linux-gnueabihf -a ! -h $TARGETDIR/lib/arm-linux-gnueabihf ]; then
    mv $TARGETDIR/lib/arm-linux-gnueabihf/* $TARGETDIR/lib
    rm -fr $TARGETDIR/lib/arm-linux-gnueabihf
    rm -fr $TARGETDIR/lib/arm-linux-gnueabi
    ln -fs . $TARGETDIR/lib/arm-linux-gnueabihf
    ln -fs . $TARGETDIR/usr/lib/arm-linux-gnueabihf
fi

