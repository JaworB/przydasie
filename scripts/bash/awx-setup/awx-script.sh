#!/bin/bash

# podman pull wymagane image z docker.io:
# docker.io/library/redis:latest
# docker.io/ansible/awx:17.1.0
# docker.io/library/postgres:12
#
# tworzysz se sciezki w /srv/containers i na koniec restorecon -Rv
# bo korzystamy z istniejacych kontextow
# no i kopiujesz tam te pliki jakie maja byc tylko pozmieniaj ajpiki
# WAZNE: /srv/containers/awx/redis/run ma miec mode 1777
# dns w postgresie mozna chyba olac...
#
# 
# . awx-script.sh
# i odpalasz se funkcje
# po drodze masz komendy w komentarzach ktore trzeba odpalic
#
# Rafal mi to dal jakis swoj brudnopis i te pliki,
# a ja se porozbijalem i obudowalem w funkcje bo latwiej.
#
# pozdro

# postgres
# # postgresql:
# CREATE USER awx WITH ENCRYPTED PASSWORD 'awxpass';
# CREATE DATABASE awx OWNER awx;
#
# # --restart=unless-stopped
#

runPostgres() {
	podman run \
		-d \
		--restart=unless-stopped \
		--name=awx_pg \
		-e POSTGRES_USER=awx \
		-e POSTGRES_PASSWORD=awxpass \
		-e POSTGRES_DB=awx \
		-v /srv/containers/postgresql/data:/var/lib/postgresql/data \
		--dns 192.168.121.1 \
		-p 5432:5432 -d \
		docker.io/library/postgres:12
}

# podman logs awx_redis

# redis

runRedis() {
	podman run \
		-d \
		--name=awx_redis \
		-v /srv/containers/awx/redis/run:/var/run/redis:rw \
		-v /srv/containers/awx/redis/redis.conf:/usr/local/etc/redis/redis.conf:ro \
		docker.io/library/redis:latest \
		/usr/local/etc/redis/redis.conf
}

# awx_web

runAwxWeb() {
	podman run \
		-d \
		--restart=unless-stopped \
		--name=awx_web \
		--user root \
		--hostname awxweb \
		-v supervisor-socket:/var/run/supervisor \
		-v rsyslog-socket:/var/run/awx-rsyslog/ \
		-v rsyslog-config:/srv/containers/awx/rsyslog/ \
		-v /srv/containers/awx/web/SECRET_KEY:/etc/tower/SECRET_KEY \
		-v /srv/containers/awx/web/environment.sh:/etc/tower/conf.d/environment.sh \
		-v /srv/containers/awx/web/credentials.py:/etc/tower/conf.d/credentials.py \
		-v /srv/containers/awx/web/nginx.conf:/etc/nginx/nginx.conf:ro \
		-v /srv/containers/awx/redis/run:/var/run/redis/:rw \
		-v /srv/containers/awx/projects:/var/lib/awx/projects:rw \
		-p 8052:8052 \
		--entrypoint /usr/bin/tini \
		docker.io/ansible/awx:17.1.0 \
		/usr/bin/launch_awx.sh
}

# 
# podman container logs awx_web
# podman exec awx_web '/usr/bin/update-ca-trust'
# 

runAwxTask() {
	podman run \
		-d \
		--name=awx_task \
		--hostname awx \
		--user root \
		-v supervisor-socket:/var/run/supervisor \
		-v rsyslog-socket:/var/run/awx-rsyslog/ \
		-v rsyslog-config:/srv/containers/awx/rsyslog/ \
		-v /srv/containers/awx/web/SECRET_KEY:/etc/tower/SECRET_KEY \
		-v /srv/containers/awx/web/environment.sh:/etc/tower/conf.d/environment.sh \
		-v /srv/containers/awx/web/credentials.py:/etc/tower/conf.d/credentials.py \
		-v /srv/containers/awx/redis/run:/var/run/redis/:rw \
		-v /srv/containers/awx/projects:/var/lib/awx/projects:rw \
		-e AWX_SKIP_MIGRATIONS=1 \
		-e SUPERVISOR_WEB_CONFIG_PATH=/etc/supervisord.conf \
		--dns 192.168.121.1 \
		--entrypoint /usr/bin/tini \
		docker.io/ansible/awx:17.1.0 \
		/usr/bin/launch_awx_task.sh
}


# podman container logs awx_task
# podman exec -it awx_task /bin/bash
# awx-manage migrate --noinput
# /usr/bin/update-ca-trust
# /usr/bin/awx-manage createsuperuser --username admin --email adam.poloniewicz@gmail.com
# /usr/bin/awx-manage create_preload_data
#






