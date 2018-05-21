FROM ubuntu:14.04

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y apache2
RUN rm -rf /var/lib/apt/lists/*

# Install apache and write hello world message
RUN echo "Hello World!" > /var/www/html/index.html

# Configure apache
RUN a2enmod rewrite
RUN sed -i -e '/^<Directory \/var\/www\/>/,/^<\/Directory>/s/\(AllowOverride \)None/\1All/' /etc/apache2/apache2.conf
RUN chown -R www-data:www-data /var/www/html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
