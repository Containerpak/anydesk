FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/anydesk"

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates libnss3 libpolkit-gobject-1-0 libxkbfile1 libxtst6 xdg-utils && \
    cpak-clean-junk
