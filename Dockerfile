FROM nginx:1.9

MAINTAINER Victor Augusto <findme@augustovictor.com.br>

# We will need curl
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

# Remove default welcome nginx page
RUN rm /usr/share/nginx/html/*

COPY configs/nginx.conf /etc/nginx/nginx.conf
COPY configs/default.conf /etc/nginx/conf.d/default.conf

# Allow us to customize the entrypoint of the image
COPY docker-entrypoint.sh /
RUN chmod 777 docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# Runs nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
