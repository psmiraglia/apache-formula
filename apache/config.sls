{% from "apache/map.jinja" import apache with context %}

{% for conf_module, conf_values in apache.config.iteritems() %}
create_{{ conf_module }}:
    file.managed:
        - name: {{ apache.extraconfdir }}/{{ conf_module }}.conf
        - makedirs: True
        - source: {{ conf_values.source }}
        - user: {{ apache.user }}
        - group: {{ apache.group }}
    {%- if conf_values.context is defined %}
        - template: jinja
        - context: {{ conf_values.context }}
    {%- endif %}
    {% if conf_values.enabled %}
enable_{{ conf_module }}:
    file.symlink:
        - name: {{ apache.enabledconfdir }}/z{{ conf_module }}.conf
        - target: {{ apache.extraconfdir }}/{{ conf_module }}.conf
        - user: {{ apache.user }}
        - group: {{ apache.group }}
    {% else %}
disable_{{ conf_module }}:
    file.absent:
        - names:
            - {{ apache.enabledconfdir }}/z{{ conf_module }}.conf
            - {{ apache.extraconfdir }}/{{ conf_module }}.conf
    {% endif %}
{% endfor %}
