# Easy Local CA

Easy Local CA is a Caddyfile + a Docker run script and compose file that I developed to make it as easy as possible to host a local Certificate Authority for an internal LAN homelab or development env.

I pretty much made it for my homelab which I also use for development.

I have found that it is a good way to manage a local CA, both easily and declaratively.

## Prereqs

You will need to have your domain name and subdomains forwarded to the host computer in a way to where your clients will know. Can either be via the DNS settings in your router or your hosts file.

Follow device manufacturer specific instructions for your router for the DNS route.

## Using it

The primary usage of it is to act as a gateway between WebGUI's of different homelab applications and the LAN that the host server is on. You should NOT use this for anything facing the internet.

- Navigate into the directory you want the files for the implementation to be in
- Clone this repo into the directory

```sh
cd /path/to/your/dir
git clone https://github.com/dbob16/elca .
```

- Modify any files as you see fit
- Create .env with your CA name and url
  - Using your text editor of choice, should look like this

```env
CA_NAME=Your Name # Replace with yours or project's name
CA_DOMAIN=ca.localhost # Replace with domain which you want /root.crt available to trust on devices
```

- Add definitions for services

You can create a file for each service, in a caddyfiles subdirectory. Set tls to internal on each one:

```sh
mkdir -p caddyfiles # Creates it if it doesn't exist
```

For instance, contents of `caddyfiles/test`, replace `site.localhost` with your own LAN domain for service:

```caddy
site.localhost {
  tls internal
  reverse_proxy test_service:123
}
```

- Start using either `sh run.sh`, `docker compose up -d`, or your own custom setup (if you're capable of doing so).

## Trusting your CA on your devices

The CA cert will be available from the web browser by going to http://CA_DOMAIN/root.crt and downloading it.

On some Linux distros you can:

```sh
wget http://CA_DOMAIN/root.crt
sudo trust anchor --store root.crt
```

Some apps will have to be closed and reopened to trust the new cert.

For other OS's and devices look up "How to install local certificate authorities root certificate" and you should find instructions on how to do so for your OS/device.
