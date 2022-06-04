FROM gitlab/gitlab-ce:latest

ENV TZ=Asia/Tehran

RUN                                                     \
        apt-get update                                  \
    &&  apt install tzdata                              \
    &&  apt install --no-install-recommends -y          \
            cron                                        \
            nano                                        \
    &&  ln -fs /usr/share/zoneinfo/$TZ /etc/localtime   \
    &&  dpkg-reconfigure -f noninteractive tzdata

RUN rm -rf /etc/cron.*/*
COPY ./cron/crontab /etc/crontab
RUN touch /var/log/cron.log && chmod 0644 /etc/crontab && crontab /etc/crontab


COPY ./cron/entrypoint.sh /entrypoint.sh
COPY ./cron/backup.sh /backup.sh


RUN ["chmod", "+x", "/entrypoint.sh", "/backup.sh"]

ENTRYPOINT ["/entrypoint.sh"]
