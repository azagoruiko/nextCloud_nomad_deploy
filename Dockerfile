FROM nextcloud:23.0.0-apache

RUN apt-get update && apt-get install -y nfs-common

COPY mount_and_entrypoint.sh /
RUN chmod a+x /mount_and_entrypoint.sh
RUN ls /var/www/html
RUN whoami
ENTRYPOINT ["/mount_and_entrypoint.sh"]
CMD ["apache2-foreground"]
