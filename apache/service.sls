{% from "apache/map.jinja" import apache with context %}

{{ apache.service }}_running:
    service.running:
        - name: {{ apache.service }}
        - enable: True
{%- if apache.config %}
        - watch:
    {%- for conf_module, conf_values in apache.config.iteritems() %}
            - file: {{ apache.extraconfdir }}/{{ conf_module }}.conf
    {%- endfor %}
{%- endif %}
