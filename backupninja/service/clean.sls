# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as backupninja with context %}

backupninja-service-clean-service-dead:
  service.dead:
    - name: {{ backupninja.service.name }}
    - enable: False
