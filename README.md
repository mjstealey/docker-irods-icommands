# docker-irods-icommands
Docker implementation of iRODS v4.1.9 iCommands

### Pull from dockerhub

Docker image is kept at dockerhub
```bash
docker pull mjstealey/docker-irods-icommands
```

### Usage:
Use an environment file to pass the required environment variables for an iinit call
```bash
docker run --rm --env-file irods-iinit.env mjstealey/docker-irods-icommands ICOMMAND_TO_PERFORM
```
- Sample environment file `irods-iinit.env` (Update as required by your iRODS installation)

  ```bash
  IRODS_HOST=localhost
  IRODS_PORT=1247
  IRODS_USER_NAME=irods
  IRODS_ZONE_NAME=tempZone
  IRODS_PASSWORD=irods
  ```

Pass environment variables indivdually
```
docker run --rm  -e IRODS_HOST=localhost \
  -e IRODS_PORT=1247 \
  -e IRODS_USER_NAME=irods \
  -e IRODS_ZONE_NAME=tempZone
  -e IRODS_PASSWORD=irods \
  mjstealey/docker-irods-icommands ICOMMAND_TO_PERFORM
```

Include a mounted volume for iput or iget calls
```bash
docker run --rm -v /PATH/ON/HOST:/workspace \
  -e IRODS_HOST=localhost \
  -e IRODS_PORT=1247 \
  -e IRODS_USER_NAME=irods \
  -e IRODS_ZONE_NAME=tempZone
  -e IRODS_PASSWORD=irods \
  mjstealey/docker-irods-icommands {iput|iget} {file/directory|resource/collection}
```

Default call generates an `ihelp` call
```bash
docker run --rm --env-file irods-iinit.env mjstealey/docker-irods-icommands
The iCommands and a brief description of each:

iadmin       - perform iRODS administrator operations (iRODS admins only).
ibun         - upload/download structured (tar) files.
icd          - change the current working directory (Collection).
ichksum      - checksum one or more Data Objects or Collections.
ichmod       - change access permissions to Collections or Data Objects.
icp          - copy a data-object (file) or Collection (directory) to another.
idbug        - interactively debug rules.
ienv         - display current iRODS environment.
ierror       - convert an iRODS error code to text.
iexecmd      - remotely execute special commands.
iexit        - exit an iRODS session (opposite of iinit).
ifsck        - check if local files/directories are consistent with the associated Data Objects/Collections in iRODS.
iget         - get a file from iRODS.
igetwild     - get one or more files from iRODS using wildcard characters.
igroupadmin  - perform group-admin functions: mkuser, add/remove from group, etc.
ihelp        - display a synopsis list of the iCommands.
iinit        - initialize a session, so you don't need to retype your password.
ilocate      - search for Data Object(s) OR collections (via a script).
ils          - list Collections (directories) and Data Objects (files).
ilsresc      - list iRODS resources.
imcoll       - manage mounted collections and associated cache.
imeta        - add/remove/copy/list/query user-defined metadata.
imiscsvrinfo - retrieve basic server information.
imkdir       - make an iRODS directory (Collection).
imv          - move/rename an iRODS Data Object (file) or Collection (directory).
ipasswd      - change your iRODS password.
iphybun      - physically bundle files (admin only).
iphymv       - physically move a Data Object to another storage Resource.
ips          - display iRODS agent (server) connection information.
iput         - put (store) a file into iRODS.
ipwd         - print the current working directory (Collection) name.
iqdel        - remove a delayed rule (owned by you) from the queue.
iqmod        - modify certain values in existing delayed rules (owned by you).
iqstat       - show the queue status of delayed rules.
iquest       - issue a question (query on system/user-defined metadata).
iquota       - show information on iRODS quotas (if any).
ireg         - register a file or directory/files/subdirectories into iRODS.
irepl        - replicate a file in iRODS to another storage resource.
irm          - remove one or more Data Objects or Collections.
irmtrash     - remove Data Objects from the trash bin.
irsync       - synchronize Collections between a local/iRODS or iRODS/iRODS.
irule        - submit a rule to be executed by the iRODS server.
iscan        - check if local file or directory is registered in iRODS.
isysmeta     - show or modify system metadata.
iticket      - create, delete, modify & list tickets (alternative access strings).
itrim        - trim down the number of replicas of Data Objects.
iuserinfo    - show information about your iRODS user account.
ixmsg        - send/receive iRODS xMessage System messages.
izonereport  - generates a full diagnostic/backup report of your Zone.

For more information on a particular iCommand:
 '<iCommand> -h'
or
 'ihelp <iCommand>'

iRODS Version 4.1.9                Jul 2016                      ihelp
```
