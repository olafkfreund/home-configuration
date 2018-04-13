#!/bin/sh

screen_get_session_name() {
    [ ! -z ${STY+x} ] && echo "(screen: ${STY#[0-9]*.})"
}
