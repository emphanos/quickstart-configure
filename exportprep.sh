# Clean up apt packages
apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean

# Remove unnecessary packages
apt-get -y install deborphan 
deborphan --guess-all | xargs apt-get -y remove --purge

# Remove apt package list cache ~40mb
# This breaks apt till an "apt-get update" happens
# rm -f /var/lib/apt/lists/* 
# rm -f /var/lib/apt/lists/partial/*

# empty the trash 
rm -rf /home/${username}/.local/share/Trash/files/*
rm -rf /home/${username}/.local/share/Trash/info/*

# trim logs
find /var/log/ -name '*.gz' -type f -print0 -exec rm '{}' \;
#logrotate -f -s /home/quickstart/quickstart/setup_scripts/logs/logrotate-status.log /home/quickstart/config/clear-all-logs.conf

# zero disk for better compression
dd if=/dev/zero of=/zerofile; sudo rm /zerofile

