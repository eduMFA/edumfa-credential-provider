# eduMFA Credential Provider

The eduMFA Credential Provider adds multifactor authentication to the Windows Desktop or Server login.
The Credential Provider communicates with the eduMFA authentication system via REST API.
[eduMFA is an open source two factor authentication system for academic institutions](https://github.com/eduMFA/edumfa)

*This project is a [fork](https://github.com/privacyidea/privacyidea-credential-provider) of the privacyIDEA Credential Provider.*

### Features
* FIDO Authentication with Passkey/WebAuthn
    - Usernameless
    - Offline
    - With RDP
* Push Token with the [eduMFA Authenticator App](https://github.com/eduMFA/authenticator)
* OTP Token like HOTP, TOTP, Email or SMS
* Configurable usage depending on scenario (Logon, Unlock with RDP or local)
* Fallback/recovery options
    - Excluded Account
    - Excluded Group
    - Fallback URL
* Configurable texts

### Known Issues

* FIDO/WebAuthn authentication is currently broken and needs to be fixed. This is tracked in [#8](https://github.com/eduMFA/edumfa-credential-provider/issues/8).

### Documentation

The documentation can be found in ``/doc``, most notably the [configuration options](https://github.com/eduMFA/edumfa-credential-provider/blob/master/doc/configuration.rst).

The complete documentation can be found at [readthedocs.io](https://edumfa-credential-provider.readthedocs.io/en/latest/index.html).

### Dependencies

This project requires [json.hpp](https://github.com/nlohmann/json) in ``CppClient/nlohmann/json.hpp``.
It also requires [libfido2](https://developers.yubico.com/libfido2/Releases/) for Windows to be in the ``$SolutionDir$`` (or adjust the include settings).
Supports libfido2 with PCSC enabled.

To build the installer, the VC143 merge modules are required to be in ``lib/merge``.
