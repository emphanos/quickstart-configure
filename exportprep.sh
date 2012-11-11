# Clean up apt packages
sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo apt-get -y clean

# Remove unnecessary packages
sudo apt-get -y install deborphan 
sudo deborphan --guess-all | xargs apt-get -y remove --purge

# Remove apt package list cache ~40mb
# This breaks apt till an "apt-get update" happens
# rm -f /var/lib/apt/lists/* 
# rm -f /var/lib/apt/lists/partial/*

# empty the trash 
sudo rm -rf /home/${username}/.local/share/Trash/files/*
sudo rm -rf /home/${username}/.local/share/Trash/info/*

# trim logs
sudo find /var/log/ -name '*.gz' -type f -print0 -exec sudo rm '{}' \;
#logrotate -f -s /home/quickstart/quickstart/setup_scripts/logs/logrotate-status.log /home/quickstart/config/clear-all-logs.conf

# zero disk for better compression
sudo dd if=/dev/zero of=/zerofile; sudo rm /zerofile

