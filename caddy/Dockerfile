# Base oficial do Caddy
FROM caddy:latest

# Instala pacotes extras (exemplo: curl, vim, nano, openssl)
RUN apk add --no-cache \
    curl \
    vim \
    nano \
    openssl \
    bash \
    tzdata

# Copia o Caddyfile customizado
COPY ./Caddyfile /etc/caddy/Caddyfile

# Copia plugins extras se necessário
# Exemplo: caddy-dns plugin para Cloudflare
# RUN xcaddy build \
#     --with github.com/caddy-dns/cloudflare

# Define diretórios de dados e configuração
VOLUME /data
VOLUME /config

# Porta padrão HTTPS
EXPOSE 443
# Porta HTTP (se quiser usar também)
EXPOSE 80

# Comando padrão
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
