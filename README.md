# sync
easy shell script that can sync files across different ubuntu server
basically, it will sync from your current machine to target machine


# How to use

## Download this repo to run

```bash
chmod +x ./sync.sh

# If you want to delete those not existing files
SOURCE_IP="172.21.148.240" TARGET_IP="172.21.148.163" DELETE_NOT_EXIST="true" ./sync.sh

# No delete, only sync
SOURCE_IP="172.21.148.240" TARGET_IP="172.21.148.163" DELETE_NOT_EXIST="false" bash ./sync.sh
```

## Using curl to run

```bash
curl -s https://raw.githubusercontent.com/Mai0313/sync/master/sync.sh | bash

# If you want to delete those not existing files
curl -s https://raw.githubusercontent.com/Mai0313/sync/master/sync.sh | SOURCE_IP="172.21.148.240" TARGET_IP="172.21.148.163" DELETE_NOT_EXIST="true" bash

# No delete, only sync
curl -s https://raw.githubusercontent.com/Mai0313/sync/master/sync.sh | SOURCE_IP="172.21.148.240" TARGET_IP="172.21.148.163" DELETE_NOT_EXIST="false" bash
```
