/etc/yum.repos.d/CentOS-Base.repo:
  file:
    - managed
    - template: jinja
    - sources:
      - salt://etc/CentOS-Base.repo

enable-epel:
  file.replace:
    - name: /etc/yum.repos.d/epel.repo
    - pattern: '^enabled=[0,1]'
    - repl: 'enabled=1'

install-postgres-9-repo:
  cmd.run:
    - runas: root
    - name: yum -y install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-6-x86_64/pgdg-centos96-9.6-3.noarch.rpm

python34:
  pkg:
    - installed
    - pkgs:
      - python34

postgresql96:
  pkg:
    - installed

postgresql96-server:
  pkg:
    - installed

/var/lib/pgsql:
  file.directory:
    - user: postgres
    - group: postgres
    - makedirs: True
    - mode: 700

/var/lib/pgsql/data:
  file.directory:
    - user: postgres
    - group: postgres
    - makedirs: True
    - mode: 700
    - clean: True

init-postgresql-db:
  cmd.run:
    - runas: root
    - name: service postgresql-9.6 initdb

install-postgresql-server:
  service.running:
    - name: postgresql-9.6
    - enable: True
    - require:
      - pkg: postgresql96-server

vagrant:
  postgres_user.present:
    - createdb: True

install-pip:
  cmd.run:
    - runas: root
    - name: cd /tmp && /usr/bin/wget https://bootstrap.pypa.io/get-pip.py && /usr/bin/python3.4 get-pip.py
    - cwd: /
    - require:
      - pkg: python34

upgrade-pip:
  cmd.run:
    - name: pip3.4 install --user pip --upgrade
    - cwd: /
    - require:
      - pkg: python34

virtualenvwrapper:
  cmd.run:
    - runas: root
    - name: pip3.4 install virtualenvwrapper
    - cwd: /

django-grappelli:
  cmd.run:
    - runas: root
    - name: pip3.4 install django-grappelli
    - cwd: /

add-workon-env:
   environ.setenv:
     - name: WORKON_HOME
     - value: /home/vagrant/.virtualenvs
     - update_minion: True

add-project-home-env:
   environ.setenv:
     - name: PROJECT_HOME
     - value: /opt/projects/
     - update_minion: True

add-wrapper-interpreter-env:
   environ.setenv:
     - name: VIRTUALENVWRAPPER_PYTHON
     - value: /usr/bin/python3.4
     - update_minion: True

create-demo-env:
  cmd.run:
    - runas: vagrant
    - name: source /usr/bin/virtualenvwrapper.sh && mkvirtualenv demo
    - cwd: /home/vagrant

/etc/motd:
  file:
    - append
    - template: jinja
    - sources:
      - salt://etc/motd.tmpl

/home/vagrant/.bashrc:
  file:
    - append
    - template: jinja
    - sources:
      - salt://etc/bashrc.tmpl

salt://scripts/create_project.sh:
  cmd.script:
    - env:
      - BATCH: 'yes'
