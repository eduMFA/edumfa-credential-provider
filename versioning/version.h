/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
**
** Copyright	2012 Dominik Pretzsch
**						2025 NetKnights GmbH
**						2026 Helsinki Systems GmbH
**
** Author		Dominik Pretzsch
**				Nils Behlen
**
**    Licensed under the Apache License, Version 2.0 (the "License");
**    you may not use this file except in compliance with the License.
**    You may obtain a copy of the License at
**
**        http://www.apache.org/licenses/LICENSE-2.0
**
**    Unless required by applicable law or agreed to in writing, software
**    distributed under the License is distributed on an "AS IS" BASIS,
**    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
**    See the License for the specific language governing permissions and
**    limitations under the License.
**
** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef _VERSION_H
#define _VERSION_H
#pragma once

#define STRINGIZE2(s) #s
#define STRINGIZE(s) STRINGIZE2(s)

/* Directory.Build.props splits /p:Version and /p:VersionCommit into these defines and injects
** them into every compile, so no version is hardcoded here. It always supplies all five. A
** missing one means the injection broke, and a silent 0.0.0.0 binary is worse than a failed
** build. */
#ifndef VERSION_MAJOR
#error "VERSION_MAJOR undefined. Build through MSBuild so Directory.Build.props can supply it."
#endif

#define VER_FILE_DESCRIPTION_STR    "eduMFA Credential Provider for Windows logon"
#define VER_FILE_VERSION            VERSION_MAJOR, VERSION_MINOR, VERSION_BUILD, VERSION_REVISION

/* Dotted numeric. Anything that parses the version uses this, the User-Agent included. */
#define VER_VERSION_STR             STRINGIZE(VERSION_MAJOR)     \
                                    "." STRINGIZE(VERSION_MINOR) \
                                    "." STRINGIZE(VERSION_BUILD) \
                                    "." STRINGIZE(VERSION_REVISION)

/* Same, plus the commit, so a shipped binary names the source it came from. */
#define VER_FILE_VERSION_STR        VER_VERSION_STR "-" STRINGIZE(VERSION_COMMIT)

#define VER_PRODUCTNAME_STR         "eduMFA CredentialProvider"

#endif
