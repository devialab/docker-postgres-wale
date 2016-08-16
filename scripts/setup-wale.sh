#!/bin/bash

echo "wal_level = archive" >> /var/lib/postgresql/data/postgresql.conf
echo "archive_mode = on" >> /var/lib/postgresql/data/postgresql.conf
echo "archive_command = '/usr/local/bin/wal-e wal-push %p'" >> /var/lib/postgresql/data/postgresql.conf
echo "archive_timeout = 60" >> /var/lib/postgresql/data/postgresql.conf

echo "restore_command = '/usr/local/bin/wal-e wal-fetch \"%f\" \"%p\"'" > /var/lib/postgresql/data/recovery.conf

