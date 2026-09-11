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

#### Bootstrapping dependencies

A PowerShell script is provided to download and place all third-party dependencies automatically.
This performs the same steps the CI workflow uses:
1. Copies the VC143 merge modules from the local Visual Studio install into ``lib/merge``.
2. Downloads libfido2 1.15.0 (win64) and extracts the static libs + headers into ``libfido2-1.15.0-nfc-enabled/``.
3. Downloads nlohmann/json v3.12.0 (single-header ``json.hpp``) into ``CppClient/CppClient/nlohmann/``.

```
pwsh ./scripts/setup-dependencies.ps1
pwsh ./scripts/setup-dependencies.ps1 -SkipMergeModules
```

### Code signing policy

Free code signing provided by [SignPath.io](https://about.signpath.io), certificate by
[SignPath Foundation](https://signpath.org).

* Committers and reviewers: [eduMFA maintainers](https://github.com/orgs/eduMFA/people)
* Approvers: [eduMFA maintainers](https://github.com/orgs/eduMFA/people)

The [GitHub Actions workflow](.github/workflows/build.yml) builds release artifacts from a tagged
commit, and SignPath signs them after manual approval.

This program will not transfer any information to other networked systems unless specifically
requested by the user or the person installing or operating it.
