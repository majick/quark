# I am done with GitHub
# Codeberg repo at:
https://codeberg.org/majick/quark

[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

This README is ported from the actual [quark homepage](https://tools.suckless.org/quark/). The below doesn't really reflect the containerized use case very well, but it's what quark is really for.

# quark
quark is an extremely small and simple HTTP GET/HEAD-only web server for static content.

The goal of this project is to do one thing and do it well, namely serving static web directories and doing that right. Most other solutions either are too complex (CGI support, dependencies on external libraries, ...) or lack features you expect (TLS, virtual hosts, partial content, not modified since, ...). quark tries to find a midway and just restrict itself to being static while still offering functions you only find in more bloated solutions and being as secure as possible (chroot, privilege dropping, strict parsers, no malloc at runtime, pledge, unveil, ...).

# Static web
We believe that most of the web does not need to be dynamic and increasing complexity on server-side applications is one of the main reasons for the web obesity crisis. The common approach nowadays is to do everything on the server, including parsing requests, modifying files and databases, generating HTML and all that using unfit languages like PHP or JavaScript, which is a security and efficiency nightmare.

Over the years we have seen massive amounts of security holes in numerous applications of tools commonly used for these jobs (PHP, node.js, CGI-implementations, ...). The reason why we are in this situation in the first place is due to the fact that the jobs of data processing and data presentation, which should be separate, converged together into one.

The solution is to rely on static regeneration independent from the web server, which just serves static files. You can still implement e.g. form handlers for dynamic content which run as their own network instance and operate independently from the web server. What's left is just to generate the static content using the database and repeating this process in case the database is updated.

This way the jobs of data processing and data presentation are separate again, with many advantages. All requests are handled with constantly low latency, with the possibility of serving everything directly from RAM (using a ramfs). Separated concerns make it very unattractive to attack the web server itself and the attack surface that is left, if it is present at all, is the separate form handler, which can be implemented in a very simple, safe and efficient manner.

In case there is an attack on this infrastructure and the attacker manages to DoS the form handler, the serving of content is still unaffected.

# TLS-support
quark does not natively support TLS. A more suckless approach than to implement TLS into it is to use a TLS reverse proxy (e.g. [tlstunnel](https://github.com/hannesm/tlstunnel), [hitch](https://hitch-tls.org/) or [stunnel](https://www.stunnel.org/) ). It accepts encrypted TLS connections and forwards them as unencrypted requests to a server. In this case, one can run such a reverse proxy to listen on a public IP address and forward the requests to a local port or UNIX-domain socket.

A more, y'know, modern thing one might choose to do is just run an actual reverse proxy, like Traefik. The 1.x versions, now kinda depracated, are trivially easy to set up in front of a `quark` container by virtue of sticking a couple of tags on the container. The 2.x versions are needlessly complex, in order to, I dunno, be enterprisey or k8s egressey or something. In any case, `quark` does its job and you can figure out how to stick TLS in front of it however you like.

# Solutions
- [saait](https://git.codemadness.org/saait/file/README.html) site generator
- [stagit](https://git.codemadness.org/stagit/file/README.html) git page generator

# Development
You can [browse](https://git.suckless.org/quark) the source code repository or get a copy with the following command:

`git clone https://git.suckless.org/quark`

or for the containerized, static `musl` version:
`git clone https://github.com/majick/quark.git`


# Author
Laslo Hunhold (dev@frign.de)

**But not me.** I'm just a maintainer of the shitty version.
