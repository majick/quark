FROM scratch

COPY data /data
COPY quark /quark
EXPOSE 8080
HEALTHCHECK NONE


ENTRYPOINT ["/quark", "-h", "0.0.0.0", "-p", "8080", "-d", "/data" ]
