# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as backupninja with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_config_file }}

backupninja-subcomponent-config-file-file-managed:
  file.managed:
    - name: {{ backupninja.subcomponent.config }}
    - source: {{ files_switch(['subcomponent-example.tmpl'],
                              lookup='backupninja-subcomponent-config-file-file-managed',
                              use_subpath=True
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ backupninja.rootgroup }}
    - makedirs: True
    - template: jinja
    - require_in:
      - sls: {{ sls_config_file }}
