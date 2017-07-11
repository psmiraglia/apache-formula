{% from "apache/map.jinja" import apache with context %}

{% if salt['grains.get']('os_family') == 'Debian' %}
    {% for module in apache.modules %}
        {% if (module.package is defined) and (module.package) %}
install_mod_{{ module.name }}:
    pkg.installed:
        - name: {{ module.package }}
        - require_in:
            {%- if module.enabled %}
            - cmd: enable_mod_{{ module.name }}
            {%- else %}
            - cmd: disable_mod_{{ module.name }}
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

{% if salt['grains.get']('os_family') == 'RedHat' %}
    {% for module in apache.modules %}
        {% if (module.package is defined) and (module.package) %}
install_mod_{{ module.name }}:
    pkg.installed:
        - name: {{ module.package }}
        - require_in:
            {% if module.enabled %}
            - cmd: enable_mod_{{ module.name }}
            {% else %}
            - cmd: disable_mod_{{ module.name }}
            {% endif %}
        {% endif %}
        {% if module.enabled %}
enable_mod_{{ module.name }}:
    cmd.script:
        - name: mod_enable.sh {{ module.name }}
        - source: salt://apache/centos/mod_enable.sh
        {% else %}
disable_mod_{{ module.name }}:
    cmd.script:
        - name: mod_disable.sh {{ module.name }}
        - source: salt://apache/centos/mod_disable.sh
        {% endif %}
    {% endfor %}
{% endif %}
