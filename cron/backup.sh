#!/usr/bin/env sh

/opt/gitlab/bin/gitlab-rake gitlab:backup:create >> /var/log/cron.log 2>&1
mv /var/opt/gitlab/backups/??????????_* /var/opt/gitlab/backups/gitlab-`date +%Y-%m-%d_%H-%M-%S`.tar