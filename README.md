##### ドキュメントルートの変更

```
# Dockerfile
FROM dorapro/php-apache

# ドキュメントルートの変更
RUN sed -i 's#/var/www/html#/var/www/public#' /etc/apache2/apache2.conf
RUN sed -i 's#/var/www/html#/var/www/public#' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i 's#/var/www/html#/var/www/public#' /etc/apache2/sites-enabled/ssl-default.conf

WORKDIR /var/www

```
