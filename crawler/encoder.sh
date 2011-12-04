#!/bin/bash

perl -e "use URI::Escape;print(uri_escape('$1'))"
