FROM ubuntu:26.04 AS source

ADD --checksum=sha256:323975ee187903fa704408bb8222f548962543ad4ed125d7f8a787f124d9e1bb https://download.anydesk.com/linux/anydesk-8.0.3-amd64.tar.gz /tmp/app.tar.gz

RUN mkdir -p /out && \
    tar -xzf /tmp/app.tar.gz --strip-components=1 -C /out

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/anydesk"

COPY --from=source /out /opt/anydesk

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates libnss3 libpolkit-gobject-1-0 libxkbfile1 libxtst6 xdg-utils && \
    ln -sf /opt/anydesk/anydesk /usr/bin/anydesk && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/anydesk.png
COPY anydesk.desktop /usr/share/applications/anydesk.desktop
