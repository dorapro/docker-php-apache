##### 使い方

```
docker run --rm -v "`pwd`:/var/www/html" -p "8000:80" dorapro/php-apache
open http://`docker-machine ip default`:8000/
```

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

##### リンク

+ https://hub.docker.com/r/dorapro/php-apache/
