database-packages:
  pkg.installed:
    - names: 
      - mysql-server
      - python-mysqldb

database-setup:
  mysql_database.present:
    - name: {{ pillar['db-config']['name'] }}
    - require:
      - pkg: database-packages

database-user:
  mysql_user.present:
    - name: {{ pillar['db-config']['username'] }}
    - password: {{ pillar['db-config']['password'] }}
    - require:
      - mysql_database: database-setup
  mysql_grants.present:
    - name: musicserver_privileges 
    - grant: all privileges
    - database: {{ pillar['db-config']['name'] }}.*
    - user: {{ pillar['db-config']['username'] }}
    - require:
      - mysql_database: database-setup
