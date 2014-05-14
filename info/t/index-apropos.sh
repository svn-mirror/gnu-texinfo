#!/bin/sh
# Copyright (C) 2014 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

. t/Init-test.inc
. t/Init-intera.inc

# Type "M-x index-apropos", look for "link" in indices, select first
# result. Then type "i" followed by <TAB> to check the indices in the
# file are still there.
$GINFO --restore $t/index-apropos.drib
RETVAL=$?

. t/Cleanup.inc
