#!/bin/bash

echo "wal_level = archive" >> /var/lib/postgresql/data/postgresql.conf
echo "archive_mode = on" >> /var/lib/postgresql/data/postgresql.conf
echo "archive_command = '/usr/local/bin/wal-e wal-push %p'" >> /var/lib/postgresql/data/postgresql.conf
echo "archive_timeout = 60" >> /var/lib/postgresql/data/postgresql.conf

echo "restore_command = '/usr/local/bin/wal-e wal-fetch \"%f\" \"%p\"'" > /var/lib/postgresql/data/recovery.conf

su - postgres -c "crontab -l | { cat; echo \"0 9 * * * /usr/local/bin/wal-e backup-push /var/lib/postgresql/data\"; } | crontab -"

su - postgres -c "crontab -l | { cat; echo \"30 9 * * * /usr/local/bin/wal-e delete --confirm retain 10\"; } | crontab -"

