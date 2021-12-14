#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# -----------------------------------------------------------------------------
# Copyright (C) Business Learning Incorporated (businesslearninginc.com)
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License at 
# <http://www.gnu.org/licenses/> for more details.
#
# -----------------------------------------------------------------------------
#
# Gnome Terminal Profiles Tweaker (GTPT)
#
# requirements:
#  --jq program installed: used to parse /data/config.json
#  --gsettings installed (part of Gnome): terminal settings store
#
# inputs:
#   -c, --columns  The number of columns in a newly created terminal window
#   -r, --rows     The number of rows in a newly created terminal window
#   -f, --font     Font name and size using Pango syntax: 'name size', e.g. 'Monospace 12'
#
# outputs:
#  --notification of script success/failure
#  --side-effect(s): terminal profiles updated
#

#
# NOTE:
#   The string '[user-config]' is an indication that some user configuration
#   may be needed to customize this script
#
# FOR MORE INFORMATION:
#   This script was written using the BaT template. To learn more, refer to
#   the A-Bash-Template project (https://github.com/richbl/a-bash-template) 
#

# -----------------------------------------------------------------------------
# script library sources and declarations
#
. "$(cd "$(dirname "$0")" && pwd)/bash-lib/args"
. "$(cd "$(dirname "$0")" && pwd)/bash-lib/general"


# [user-config] set any external program dependencies here
declare -a REQ_PROGRAMS=('jq' 'gsettings')

# -----------------------------------------------------------------------------
# perform script configuration, arguments parsing, and validation
#
check_program_dependencies "${REQ_PROGRAMS[@]}"
display_banner
scan_for_args "$@"
check_for_args_completeness

# -----------------------------------------------------------------------------
# [user-config]
# Any code from this point on is custom code, using the sevices provided
# through this BaT (https://github.com/richbl/a-bash-template) template
#

# -----------------------------------------------------------------------------
# get terminal profile value from profile UUID and key passed in
#
function get_profile_key {
  gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$1"/ "$2"
}

# -----------------------------------------------------------------------------
# set terminal profile value from profile UUID, key, and value passed in
#
function set_profile_key {
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$1"/ "$2" "$3"
}

# -----------------------------------------------------------------------------
# Gnome Terminal Profiles Tweaker
#

# declare terminal profile identifiers (as array) and arguments
profiles=()
profile_count=0
profile_name=""
summary=""

ARG_COLS="$(get_config_arg_value columns)"
ARG_ROWS="$(get_config_arg_value rows)"
ARG_FONT="$(get_config_arg_value font)"
readonly ARG_COLS
readonly ARG_ROWS
readonly ARG_FONT

# get list of profile identifiers
IFS=", " read -r -a profiles <<< "$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d "\'[]")?"
profile_count=${#profiles[@]}

# check if no profile identifiers found
if [ ! "${profile_count}" ]; then
  printf "\n%s\n" "Error: no terminal profile identifiers found."
  quit 1
fi

printf "%s\n\n" "$profile_count profiles found"

# loop through list of profiles and update elements 
for ((i=0;i<profile_count;i++)); do

  summary=""

  # get profile name
  profile_name=$(get_profile_key "${profiles[i]}" "visible-name")

  if [ -n "${ARG_FONT}" ]; then

    # get/set profile font
    summary+="Font: $(get_profile_key "${profiles[i]}" "font")-->"
    set_profile_key "${profiles[i]}" "font" "$(get_config_arg_value font)"
    summary+="$(get_profile_key "${profiles[i]}" "font"). "

    # set profile font to display in terminal (enable custom font)
    set_profile_key "${profiles[i]}" "use-system-font" "false"

  fi

  if [ -n "${ARG_COLS}" ]; then

    # get/set profile columns
    summary+="Columns: $(get_profile_key "${profiles[i]}" "default-size-columns")-->"
    set_profile_key "${profiles[i]}" "default-size-columns" "$(get_config_arg_value columns)"
    summary+="$(get_profile_key "${profiles[i]}" "default-size-columns"). "

  fi

  if [ -n "${ARG_ROWS}" ]; then

    # get/set profile rows
    summary+="Rows: $(get_profile_key "${profiles[i]}" "default-size-rows")-->"
    set_profile_key "${profiles[i]}" "default-size-rows" "$(get_config_arg_value rows)"
    summary+="$(get_profile_key "${profiles[i]}" "default-size-rows"). "

  fi

  if [ -z "${summary}" ]; then
    summary="Profile #$((i + 1 )) $profile_name >> no changes"
  else
    summary="Profile #$((i + 1)) $profile_name >> $summary"
  fi

  printf "%s\n" "$summary"

done