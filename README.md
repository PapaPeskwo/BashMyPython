# ScriptHub

- [ScriptHub](#scripthub)
  - [Description](#description)
    - [7.sh](#7sh)
    - [Usage](#usage)
    - [sshsetup.sh](#sshsetupsh)
    - [Usage](#usage-1)
    - [Example](#example)


| Script Name | Description | Type | How to run |
| ----------- | ----------- | ---- | ---------- |
| [7.sh](#7sh) | Compresses a file or dir into .7z and encrypts it | bash | 7 [-p] /path/to/file_or_directory |
| [sshsetup.sh](#sshsetupsh) | sets up SSH keys and configures SSH for a specified host | bash | sshsetup.sh <key_path> <host_alias> <user> <hostname> [-c] [-p <port>] |

## Description

### 7.sh
This script compresses a specified file or directory into a `.7z` archive. Optionally, it can password-encrypt the archive and generate a random password for it.

### Usage
```bash
7 [-p] /path/to/file_or_directory
```
- `-p`: Password-encrypts the zipped file automatically and echoes the generated password.

### sshsetup.sh
This script sets up SSH keys and configures SSH for a specified host. It generates an RSA key pair, copies the public key to the specified host, and updates the SSH config file. Optionally, it can connect to the host after setup.

### Usage
```bash
sshsetup.sh /<key_path> <host_alias> <user> <hostname> [-c] [-p <port>]
```
- `<key_path>`: Path to the SSH key (relative to `~/.ssh`).
- `<host_alias>`: Alias for the host.
- `<user>`: Username for the host.
- `<hostname>`: Hostname or IP address of the host.
- `-c`: Connect to the host after setup (optional).
- `-p <port>`: Port number for SSH (optional, default is 22).

### Example
```bash
sshsetup.sh /id_myserver myserver admin 192.168.1.2 -c -p 2222
```
```bash
ssh myserver
```
