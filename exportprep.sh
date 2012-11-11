# Remove unnecessary packages
sudo apt-get -y install deborphan 
sudo deborphan --guess-all | xargs sudo apt-get -y remove --purge

# Clean up apt packages
sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo apt-get -y clean

# Remove apt package list cache ~40mb
# This breaks apt till an "apt-get update" happens
# rm -f /var/lib/apt/lists/* 
# rm -f /var/lib/apt/lists/partial/*

# empty the trash FIXME can probably use find for this
#sudo rm -rf /home/${username}/.local/share/Trash/files/*
#sudo rm -rf /home/${username}/.local/share/Trash/info/*

# trim logs FIXME
#sudo find /var/log/ -name '*.gz' -type f -print0 -exec sudo rm '{}' \;
#logrotate -f -s /home/quickstart/quickstart/setup_scripts/logs/logrotate-status.log /home/quickstart/config/clear-all-logs.conf

# zero disk for better compression
echo " * Zeroing disk.  This takes awhile ..."
sudo dd if=/dev/zero of=/zerofile; sudo rm /zerofile

