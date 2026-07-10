.. _installation:

Installation
===========

Prerequisites
-------------

To use the eduMFA Credential Provider, you need to have a eduMFA
Authentication System. The installation and setup of this backend is covered
in another documentation [#eduMFASetup]_.

Ask the company NetKnights to get an evaluation version of the eduMFA
Credential Provider [#contact]_.

MSI package
-----------

The eduMFA Credential Provider comes as 64bit MSI package.
You can install it manually or use your software distribution tool.
In the installer, you can configure the most important options, but some less commonly used
ones are not in the installer. You can find all options and explanations here `ref:configuration`


Automated Deployment
--------------------

If you want to deploy the eduMFA Credential Provider to a lot of targets with automation, here are some options on how
to configure it automatically:
1. You can set the properties of the installer via command line: ``c:\> msiexec /i yourmsi.msi THEPROPERTYNAME=valueofproperty``.
The properties are usually the registry entry name in all caps, so two_step_send_password would be TWO_STEP_SEND_PASSWORD.
A list of properties can be found `Link here https://github.com/eduMFA/edumfa-credential-provider/blob/master/WiXSetup/Product.wxs#L284`_

2. Use the `Link Orca/SuperOrca Tool https://www.heise.de/download/product/superorca-56658`_ to prepare a MSI with the properties set:
.. image:: /install_images/orca.png

3. Automate the manual installation described in the next paragraph.

Manual Installation
-------------------

The eduMFA Credential Provider and Filter can also be registered manually.
To do this, the file ``EduMFACredentialProvider.dll`` has to be put into ``%windir%\System32``.
(If desired, the ``EduMFACredentialProviderFilter.dll`` can be added aswell).
Next, the eduMFA Credential Provider has to be registered to be loaded into the logon process.
This is done by adding its CLSID to the list of Credential Providers at
``HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\``.
Add a new key here with the name ``{7BAF541E-F8E0-4EDF-B69A-BD2771139E8E}`` (the CLSID).
Afterwards set the data of the default to ``EduMFACredentialProvider``.
Finally, the DLL has to be registered with the system. To do this, go to ``HKEY_CLASSES_ROOT\CLSID\``
and add a new key with the CLSID from above. Add another key to the on just created with the name
``InprocServer32``. Set the default data to ``EduMFACredentialProvider.dll`` and add another
REG_SZ with the name ``ThreadingModel`` and data ``Apartment``.
Now the eduMFA Credential Provider is registered and should be visible at the next Login attempt.
This can also be done via the file ``RegisterProvider.reg``.

If you wish to also use the eduMFA Credential Provider Filter, do the steps above again with the
CLSID of the Filter which is ``{34065473-D75F-4BC2-9782-E98E63ED0D41}`` and registration at
``HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Provider Filters\``.
Alternativly, the file ``RegisterFilter.reg`` can be used.

To unregister, the corresponding files ``UnregisterXXX.reg`` can be used.
This does not remove the configuration, DLL files or CLSID entries, it only removes the Provider or Filter
from the Authentication flow at ````HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\``.


.. [#eduMFASetup] https://edumfa.readthedocs.io
.. [#contact] https://edumfa.io
