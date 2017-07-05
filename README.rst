======
apache
======

Install and configure a Apache Web Server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``apache.packages``
-------------------

Installs the Apache web server package(s) from distro repository. The main
package version can be specified with pillar key ``apache:version``.

``apache.modules``
------------------

Only for Debian systems.

Manages Apache web server modules by reading from ``apache:modules`` pillar
key (see ``pillar.example``). Each element of the list is a dictionary that
must contain the keys ``name`` and ``enabled``. Optionally, it could include
the key ``package`` to specify the name of the package providing the module.
If missing, the package will be installed.

``apache.service``
------------------

Enables and runs the Apache service.

References
==========

-  `Apache Web Server <https://httpd.apache.org/>`__
-  `Salt Formulas <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`__
