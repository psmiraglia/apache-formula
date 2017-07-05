{% from "apache/map.jinja" import apache with context %}

{% if salt['grains.get']('os_family') == 'Debian' %}
    {% for module in apache.modules %}
        {% if (module.package is defined) and (module.package) %}
install_mod_{{ module.name }}:
    pkg.installed:
        - name: {{ module.package }}
        - require_in:
            {%- if module.enabled %}
            - apache_module: enable_mod_{{ module.name }}
            {%- else %}
            - apache_module: disable_mod_{{ module.name }}
            {%- endif %}
        {% endif %}
        {% if module.enabled %}
enable_mod_{{ module.name }}:
    cmd.run:
        - name: a2enmod {{ module.name }}
        - unless: test -e {{ apache.modulesdir }}/{{ module.name }}.load
        {% else %}
disable_mod_{{ module.name }}:
    cmd.run:
        - name: a2dismod -f {{ module.name }}
        - unless: test ! -e {{ apache.modulesdir }}/{{ module.name }}.load
        {% endif %}
    {% endfor %}
{% endif %}
