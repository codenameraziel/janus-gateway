FROM ubuntu:22.04

# Dependências necessárias
RUN apt-get update && apt-get install -y \
    build-essential \
    libmicrohttpd-dev \
    libjansson-dev \
    libssl-dev \
    libsofia-sip-ua-dev \
    libglib2.0-dev \
    libopus-dev \
    libogg-dev \
    libcurl4-openssl-dev \
    liblua5.3-dev \
    libconfig-dev \
    pkg-config \
    git \
    cmake \
    automake \
    autoconf \
    libtool \
    gengetopt \
    libnice-dev \
    libsrtp2-dev \
    libwebsockets-dev \
    libusrsctp-dev \
    gettext \
    nano \
    coreutils \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Compilar RNNoise manualmente
RUN git clone https://github.com/xiph/rnnoise.git /opt/rnnoise \
    && cd /opt/rnnoise \
    && ./autogen.sh \
    && ./configure --prefix=/usr/local \
    && make -j$(nproc) \
    && make install \
    && ldconfig

# Clonar e compilar Janus com suporte HTTP, WebSockets, DataChannels e RNNoise
RUN git clone https://github.com/meetecho/janus-gateway.git /opt/janus \
    && cd /opt/janus \
    && sh autogen.sh \
    && ./configure --prefix=/usr/local --enable-websockets --enable-data-channels --enable-rnnoise \
    && make -j$(nproc) \
    && make install \
    && make configs \
    && ldconfig

# Garantir que o binário janus esteja no PATH
ENV PATH="/usr/local/bin:${PATH}"

# Expor portas típicas do Janus
EXPOSE 8088 8188 8288 7088 7888 5004/udp 5010/udp

# Comando padrão
CMD ["janus", "-F", "/usr/local/etc/janus"]
