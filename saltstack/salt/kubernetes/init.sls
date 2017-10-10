kubernetes-repo:
  pkgrepo.managed:
    - humanname: Official Kubernetes Repository
    {% if grains['os'] == 'Ubuntu' %}
    - name: "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    - file: /etc/apt/sources.list.d/kubernetes.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
    {% endif %}
    {% if grains['os'] == 'CentOS' %}
    - baseurl: https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
    - enabled: 1
    - file: /etc/yum.repos.d/kubernetes.repo
    - key_url: https://packages.cloud.google.com/yum/doc/yum-key.gpg
    {% endif %}
    - gpgcheck: 1
    - require_in:
      - pkg: kubectl
      - pkg: kubelet
      - pkg: kubeadm

kubectl:
  pkg.latest:
    - refresh: True

kubelet:
  pkg.latest:
    - refresh: True

kubeadm:
  pkg.latest:
    - refresh: True

