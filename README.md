# Russian PAC file generator, light version

Generator of PAC files for the [AntiZapret](https://antizapret.prostovpn.org/) service.

This collection of scripts creates a proxy [auto-configuration](https://en.wikipedia.org/wiki/Proxy_auto-config) file
containing a list of websites blocked in the territory of the Russian Federation by Roskomnadzor and other state authorities.
The PAC file can be used in browsers to automatically proxy blocked resources.

In addition to its primary purpose, it can also create:

* A client configuration file (client-config, CCD) with blocked IP address ranges for OpenVPN;
* A file with blocked domain zones for Squid;
* A file with blocked domain zones in a LUA variable, for use with the knot-resolver DNS resolver.

### Dependencies

* Bash
* cURL
* GNU coreutils
* GNU AWK (gawk)
* sipcalc
* idn
* Python 3.6+
* dnspython 2.0.0+

### Configuration Files

* `{in,ex}clude-{hosts,ips}-dist` - distribution configuration, intended to be modified by the repository author;
* `{in,ex}clude-{hosts,ips}-custom` - user configuration, intended to be modified by the end user of the script;
* `exclude-regexp-dist.awk` - file with various blocked "junk" that bloats the PAC file:
  site mirrors, non-working websites, etc.;
* `config.sh` - file with proxy addresses and other configuration.

### Installation and usage

#### Debian/Ubuntu

Download the deb package from the release page and install it.

```shell
wget -qO- https://api.github.com/repos/twin-stella/antizapret-pac-generator-light/releases/latest |\
    awk -F'"' '/"browser_download_url"/ {print $(NF-1)}' |\
    grep '.deb$' |\
    wget -q -i- --show-progress
sudo apt install antizapret-pac-generator*.deb

Edit `/etc/antizapret-pac-generator/config.sh`, `/usr/local/share/antizapret-pac-generator/doall.sh`,
and `/usr/local/share/antizapret-pac-generator/process.sh` to fit your needs,
then run `/usr/local/share/antizapret-pac-generator/doall.sh`.

```

#### Other

Clone the git repository, edit `config/config.sh`, `doall.sh`, and `process.sh` to fit your needs, then run `doall.sh`.
