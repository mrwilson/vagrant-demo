remove-old-java:  
  pkg.removed:
    - names:
      - openjdk-6-jre
      - openjdk-6-jre-headless
      - openjdk-6-jre-lib

app-requirements:
  pkg.installed:
    - names:
      - openjdk-7-jdk
      - openjdk-7-jre
      - maven
      - git-core
    - require:
      - pkg: remove-old-java

app-source:
  git.latest:
    - name: git://github.com/mrwilson/aoko.git
    - target: {{ pillar['app']['target_dir'] }}
    - runas: vagrant
    - require:
      - pkg: app-requirements

app-config:
  file.managed:
    - name: {{ pillar['app']['target_dir'] }}/src/main/resources/spring/musicserver.properties
    - source: salt://app/app.properties
    - template: jinja
    - user: vagrant
    - mode: 644
    - require:
      - git: app-source

app-build:
  cmd.run:
    - name: mvn clean package
    - cwd: {{ pillar['app']['target_dir'] }}
    - user: vagrant
    - require:
      - file: app-config
