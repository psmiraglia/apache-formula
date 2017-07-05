{% from "apache/map.jinja" import apache with context %}

{{ apache.service }}_running:
    service.running:
        - name: {{ apache.service }}
        - enable: True
