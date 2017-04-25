enable-epel:
  file.replace:
    - name: /etc/yum.repos.d/epel.repo
    - pattern: '^enabled=[0,1]'
    - repl: 'enabled=1'

python-pip:
  pkg:
    - installed
    - pkgs:
      - python34-pip

upgrade-pip:
  cmd.run:
    - name: pip3 install --upgrade pip
    - cwd: /
    - require:
      - pkg: python-pip

virtualenvwrapper:
  cmd.run:
    - name: pip3 install virtualenvwrapper
    - cwd: /
    - require:
      - pkg: python-pip
