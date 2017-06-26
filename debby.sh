#!/bin/bash
#
# Copyright (c) 2017 David Vilela
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License 
# as published by the Free Software Foundation, either version 2 
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License 
# along with this program; if not, see <http://www.gnu.org/licenses/>.

main()
{
    # Test /var/lib/dpkg/lock to ensure we can install packages
    lock=$(fuser /var/lib/dpkg/lock)

    if [ ! -z "$lock" ]; then
        zenity --error --title="Debby" --text="Another program is installing or updating packages. Please wait until this process finishes and then launch Debby again."
        exit 0
    fi

    # Repair installation interruptions
    dpkg --configure -a

    # Instructions dialog
     while true; do

        if zenity --question --title="Debby" \
                  --text="Please select a deb file to install." \
                  --ok-label="Select" \
                  --cancel-label="Cancel"
        then
            break
        else
            if [[ $? == 1 ]]; then
                if zenity --question --title="Debby" --text="Are you sure you want to exit?"; then
                    return
                else
                    continue
                fi
            fi
        fi
    done

    # Selection dialog
    while true; do

        file=$(zenity --file-selection --title="Debby")

        # Check for closed window / cancel button
        if [[ $? == 1 ]]; then
            if zenity --question --title="Debby" --text="Are you sure you want to exit?"; then
                break
            else
                continue
            fi
        fi

        # Check for a valid deb package
        if [[ "$file" == *".deb" ]]; then

            # Warning message and confirmation
            message="$(basename $file) is about to be installed. "
            message+="You won't be able to cancel this operation once started.\n"
            message+="Are you sure you want to continue?"

            if ! zenity --question --title="Debby" --text "$message"; then
                continue
            fi

            (apt-get -y install "$file") | zenity --progress --pulsate --no-cancel --auto-close --title="Debby" --text="Installing $(basename $file)"

            if [[ $? == 0 ]]; then
                zenity --info --title="Debby" --text="Package successfully installed."
                break
            else
                zenity --error --title="Debby" --text="An error occurred while installing this package. May be it's not a valid package."
                break
            fi
        else
            zenity --error --title="Debby" --text="This is not a valid deb file, try again."
        fi

    done
}

getPassword()
{
  sudo -k

  while true; do
    password=$(zenity --password --title="Debby")

    # Check for closed window / cancel button
    if [[ $? == 1 ]]; then
        if zenity --question --title="Debby" --text="Are you sure you want to exit?"; then
          return 1
        else
          continue
        fi
    fi

    # Check for correct password
    myid=$(echo $password | sudo -S id -u)

    if [[ $? == 0 ]] && [[ $myid == 0 ]]; then
      echo $password
      return 0
    else
        zenity --info --title="Debby" --text="Wrong password, try again"
    fi
  done
}

# RUN

# Check for root permissions and ask for password in other case
if [[ $(id -u) == 0 ]]; then
    main
else
    password=$(getPassword)

    if [[ $? == 0 ]]; then
      echo $password | sudo -S "$0"
    else
      exit 0
    fi
fi

exit 0
