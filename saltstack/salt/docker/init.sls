{% if grains['lsb_distrib_codename'] == 'trusty' %}                                                                                                                                                                 
extra_packages:
  pkg.installed:
    - refresh: True
    - pkgs:
      - linux-image-extra-{{ grains['kernelrelease'] }}
      - linux-image-extra-virtual
{% endif %}

{% if grains['os'] == 'Ubuntu' %}

docker-repo:
  pkgrepo.managed:
    - humanname: Official Docker Repository
    - name: deb [arch={{ grains['osarch'] }}] https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} stable
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/docker.list
    - gpgkey: https://download.docker.com/linux/ubuntu/gpg
    - keyid: 0EBFCD88
    - keyserver: keyserver.ubuntu.com
    - gpgcheck: 1
    - require_in:
      - pkg: docker-ce

{% endif %}

docker-ce:  
  pkg.installed:
    - force_yes: True

docker:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: docker-ce

docker-group:
  group.present:
    - name: docker
    - system: True
    - addusers:
      - ubuntu