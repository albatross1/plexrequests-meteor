---
- include_role:
    name: variables

########## Unique for TLD
- name: Register TLD if it exists
  shell: "cat /var/plexguide/tld.{{ role_name }}"
  register: tld
  ignore_errors: True
##########

- name: Remove PlexRequests Container
  docker_container:
    name: PlexRequests
    state: absent

############ Directories
- name: Create Basic Directories
  file: "path={{item}} state=directory mode=0775 owner=1000 group=1000 recurse=true"
  with_items:
    - /opt/appdata/PlexRequests

- name: Download PlexRequests

    docker pull linuxserver/plexrequests
    owner: 1000
    group: 1000
    force: no
  ignore_errors: True


- name: Deploy PlexRequests Container
  docker_container:
    name: PlexRequests
    ## image: linuxserver/plexrequests
    image: linuxserver/plexrequests
    pull: yes
    cpu_shares: 128
    published_ports:
      - "{{ports.stdout}}3000:3000"
    env:
      PUID: "1000"
      PGID: "1000"
    volumes:
      - /opt/appdata/plexrequests:/config
      - /etc/localtime:/etc/localtime:ro
    networks:
      - name: plexguide
        aliases:
          - plexrequests
    restart_policy: always
    state: started
    labels:
      traefik.enable: "true"
      traefik.frontend.redirect.entryPoint: "https"
      traefik.frontend.rule: "Host:ombi.{{domain.stdout}},requests.{{domain.stdout}},request.{{domain.stdout}}{{tld.stdout}}"
      traefik.port: "3000"
