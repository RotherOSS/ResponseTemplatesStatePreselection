.. toctree::
    :maxdepth: 2
    :caption: Contents

Sacrifice to Sphinx
===================

Description
===========

Extends response template configuration by se- lectable ticket state which will be pre-select- ed upon answering a ticket. 

Configuring pre-selected ticket states for response templates
---------------

This package adds a new option called "State pre-selection for Templates" within the "Ticket Settings" in the ADMIN panel. You can set a ticket state to response template. The ticket state will be pre-selected when answering a ticket via a response template.

.. note::

    The configured ticket states must be allowed in ticket context as next state. If this should not  
    be the case, no next state will be pre-selected when answering a ticket.
 

System requirements
===================

Framework
---------
OTOBO 10.1.x

Packages
--------
\-

Third-party software
--------------------
\-


Installation
========

The following instructions explain how to install the package. There are two possibilities.

1. Admin Interface
~~~~~~~~~~~~

Please use the following URL to install the package utilizing the Admin Interface (please note that you need to be in the "admin" group).
https://localhost/otobo/index.pl?Action=AdminPackageManager

2. Command Line
~~~~~~~~~~~

Whenever you cannot use the Admin Interface for whatever reason, you may use the following command line tool ("bin/otobo.Console.pl Admin::Package::Install") instead.

.. code-block:: bash

     otobo_admin> bin/otobo.Console.pl Admin::Package::Install /path/to/ResponseTemplatesStatePreselection-10.0.1.opm
 
 
 Usage
 =====

1. Set state for response template
--------------

Go to the admin interface, and look for the 'State pre-selection for Templates' within the 'Ticket Settings' section and click on this link.

Once on the 'Manage ticket state pre-selections for response templates' screen click on one of the listed answer templates, then on the edit screen set a new value for 'Pre-selected ticket state' field.

Zoom a ticket and open the reply screen, verify the 'Pre-selected ticket state' should be set on the 'Next ticket state' field.
 

Configuration Reference
=======================

Frontend::Admin::ModuleRegistration
------------------------------------------------------------------------------------------------------------------------------

Frontend::Module###AdminResponseTemplatesStatePreselection
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Frontend module registration for the admin interface.

Frontend::Admin::ModuleRegistration::AdminOverview
------------------------------------------------------------------------------------------------------------------------------

Frontend::NavigationModule###AdminResponseTemplatesStatePreselection
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Admin area navigation for the agent interface.

Frontend::Admin::ModuleRegistration::Loader
------------------------------------------------------------------------------------------------------------------------------

Loader::Module::AdminResponseTemplatesStatePreselection###002-ResponseTemplatesStatePreselection
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Loader module registration for the agent interface.

Frontend::Admin::ModuleRegistration::MainMenu
------------------------------------------------------------------------------------------------------------------------------

Frontend::Navigation###AdminResponseTemplatesStatePreselection###002-ResponseTemplatesStatePreselection
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Main menu item registration.

Frontend::Agent
------------------------------------------------------------------------------------------------------------------------------

PreApplicationModule###ResponseTemplatesStatePreselection
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Provides state preselection functionality for responses.




About
=======

Contact
-------
| Rother OSS GmbH
| Email: hello@otobo.de
| Web: https://otobo.de

Version
-------
Author: |doc-vendor| / Version: |doc-version| / Date of release: |doc-datestamp|
Author: OTRS AG / Version: 6.* / 2018-07-24
