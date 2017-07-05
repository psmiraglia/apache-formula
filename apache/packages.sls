{% from "apache/map.jinja" import apache with context %}

install_{{ apache.package }}:
    pkg.installed:
        - name: {{ apache.package }}
{%- if apache.version %}
        - version: {{ apache.version }}
{%- endif %}
