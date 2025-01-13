#!/bin/bash

show_menu() {
    echo "1) Update & Upgrade the System"
    echo "2) Update,Upgrade & Rebooting the System"
    echo "3) Update,Upgrade & Shutting down the System"
    echo "4) Exit"
}

update_and_upgrade_system() {

    # Fetches the latest versions of your package-lists
    # Downloading and installing the updates for each outdated package and dependency on your system
    sudo pacman -Syu
    echo "System upgraded!"
    sleep 0.5

    # Clean up pacman
    sudo pacman -Rns $(pacman -Qdtq)
    sudo pacman -Sc
    echo "System cleaned!"
    sleep 0.5
}

update_upgrade_and_shutdown_system(){

    # Update Upgrade and clen up
    update_and_upgrade_system

    # Shutdding down now
    echo "System Upgraded, Shutting down now!"
    sleep 1
    sudo shutdown now

}

update_upgrade_and_reboot_system(){

    # Update Upgrade and clen up
    update_and_upgrade_system

    # Rebooting now
    echo "System Upgraded, Rebooting now!"
    sleep 1
    sudo reboot now

}


clear
echo "---> Full System Upgrade-Script V1.0.1 (Arch/pacman) <---"
while true; do
    show_menu
    read -p "Choose an option: " choice

    case $choice in
        1)
            update_and_upgrade_system
            sleep 0.5
            clear
            echo "System Upgraded and Cleaned ᗜˬᗜ"
            break
            ;;
        2)
            update_upgrade_and_reboot_system
            break
            ;;
        3)
            update_upgrade_and_shutdown_system
            break
            ;;
        4)
            clear
            echo "You changed your mind i see"
            break
            ;;
        *)
            clear
            echo "---> Full System Upgrade-Script V1.0.1 (Arch/pacman) <---"
            echo "WARNING:'$choice' is a invalid option!"
            ;;
    esac
done
