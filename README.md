# docker-kali-crackbase

Wrapping up `kali` linux, with preinstalled tools to deal with static hard drive forensics.

## Usage

### Make a forensic copy on a hard drive

```sh
docker-compose run kali mkimg /dev/sda mybackup.dd
```

The resulting file with be in the relative `output/` directory.