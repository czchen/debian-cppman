#!/usr/bin/env bash
#
# pager_vim.sh
#
# Copyright (C) 2010 - 2015  Wei-Ning Huang (AZ) <aitjcize@gmail.com>
# All Rights reserved.
#
# This file is part of cppman.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

# viewer.sh is a lauches vim as man page viewer and provides some convinient
# settings
#

[ -n "`echo $LC_ALL | sed 's/-//g' | grep -i utf8`" ] && dev=utf8 || dev=ascii

escape=$(echo -e '\033')
vim=$(which vim 2> /dev/null)

if [ $? -eq 0 ]; then
  gunzip -c "$1" | groff -t -c -m man -T$dev -rLL=$2n -rLT=$2n 2> /dev/null | sed "s/$escape\[[^m]*m//g" | col -x -b | vim -R -c "let g:page_name=\"$4\"" -S $3 -
else
  gunzip -c "$1" | groff -t -c -m man -T$dev -rLL=$2n -rLT=$2n 2> /dev/null | less
fi
