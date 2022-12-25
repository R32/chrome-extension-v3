chrome extension v3
------

Extern type definitions for Chrome Extension


### summary

- [x] accessibilityFeatures

  Use the `chrome.accessibilityFeatures` API to manage Chrome's accessibility features.
  This API relies on the [ChromeSetting prototype of the type API](https://developer.chrome.com/docs/extensions/reference/types/#ChromeSetting)
  for getting and setting individual accessibility features.
  In order to get feature states the extension must request `accessibilityFeatures.read` permission.
  For modifying feature state, the extension needs `accessibilityFeatures.modify` permission.
  Note that `accessibilityFeatures.modify` does not imply `accessibilityFeatures.read` permission.

  ```
  @chrome-permission: accessibilityFeatures.modify
  @chrome-permission: accessibilityFeatures.read
  ```

- [x] action

  Use the `chrome.action` API to control the extension's icon in the Google Chrome toolbar.

  ```
  @since Chrome 88
  @chrome-manifest action
  @chrome-min-manifest MV3
  ```

- [x] alarms

  Use the `chrome.alarms` API to schedule code to run periodically
  or at a specified time in the future.

  ```
  @chrome-permission alarms
  ```

- [x] audio

  The `chrome.audio` API is provided to allow users to get information about
  and control the audio devices attached to the system. This API is currently
  only available in kiosk mode for ChromeOS.

  ```
  @since Chrome 59
  @chrome-permission audio
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] automation

  The `chrome.automation` API allows developers to access the automation (accessibility) tree for the browser.
  The tree resembles the DOM tree, but only exposes the _semantic_ structure of a page.
  It can be used to programmatically interact with a page by examining names, roles, and states,
  listening for events, and performing actions on nodes.

  ```
  @alpha
  @chrome-manifest automation
  @chrome-channel dev
  @chrome-disallow-service-workers
  ```

- [x] bookmarks

  Use the `chrome.bookmarks` API to create, organize, and otherwise manipulate bookmarks.
  Also see [Override Pages](https://developer.chrome.com/docs/extensions/override),
  which you can use to create a custom Bookmark Manager page.

  ```
  @chrome-permission bookmarks
  ```

- [x] browsingData

  Use the `chrome.browsingData` API to remove browsing data from a user's local profile.

  ```
  @chrome-permission browsingData
  ```

- [ ] certificateProvider

  Use this API to expose certificates to the platform which can use these certificates for TLS authentications.

  ```
  @since Chrome 46
  @chrome-permission certificateProvider
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [x] commands

  Use the commands API to add keyboard shortcuts that trigger actions in your extension,
  for example, an action to open the browser action or send a command to the extension.

  ```
  @chrome-manifest commands
  ```

- [x] contentScripts (@since Chrome 88)

  Stub namespace for the "content\_scripts" manifest key.

- [x] contentSettings

  Use the `chrome.contentSettings` API to change settings that control whether
  websites can use features such as cookies, JavaScript, and plugins. More generally speaking,
  content settings allow you to customize Chrome's behavior on a per-site basis instead of globally.

  ```
  @chrome-permission contentSettings
  ```

- [x] contextMenus

  Use the `chrome.contextMenus` API to add items to Google Chrome's context menu.
  You can choose what types of objects your context menu additions apply to,
  such as images, hyperlinks, and pages.

  ```
  @chrome-permission contextMenus
  ```

- [x] cookies

  Use the `chrome.cookies` API to query and modify cookies, and to be notified when they change.

  ```
  @chrome-permission cookies
  ```

- [x] debugger

  The `chrome.debugger` API serves as an alternate transport for
  Chrome's [remote debugging protocol](https://developer.chrome.com/devtools/docs/debugger-protocol).
  Use `chrome.debugger` to attach to one or more tabs to instrument network interaction,
  debug JavaScript, mutate the DOM and CSS, etc. Use the Debuggee `tabId` to target tabs with
  sendCommand and route events by `tabId` from onEvent callbacks.

  ```
  @chrome-permission debugger
  ```

- [x] declarativeContent

  Use the `chrome.declarativeContent` API to take actions depending on the content of a page,
  without requiring permission to read the page's content.

  ```
  @chrome-permission declarativeContent
  ```

- [x] declarativeNetRequest

  The `chrome.declarativeNetRequest` API is used to block or modify network requests
  by specifying declarative rules. This lets extensions modify network requests without
  intercepting them and viewing their content, thus providing more privacy.

  ```
  @since Chrome 84
  @chrome-permission declarativeNetRequest
  @chrome-permission declarativeNetRequestWithHostAccess
  ```

- [x] desktopCapture

  Desktop Capture API that can be used to capture content of screen, individual windows or tabs.

  ```
  @chrome-permission desktopCapture
  ```

- [ ] devtools.inspectedWindow

  Use the `chrome.devtools.inspectedWindow` API to interact with the inspected window:
  obtain the tab ID for the inspected page, evaluate the code in the context of
  the inspected window, reload the page, or obtain the list of resources within the page.

  ```
  @chrome-manifest devtools_page
  ```

- [ ] devtools.network

  Use the `chrome.devtools.network` API to retrieve the information about
  network requests displayed by the Developer Tools in the Network panel.

  ```
  @chrome-manifest devtools_page
  ```

- [ ] devtools.panels

  Use the `chrome.devtools.panels` API to integrate your extension into
  Developer Tools window UI: create your own panels, access existing panels, and add sidebars.

  ```
  @chrome-manifest devtools_page
  ```

- [ ] devtools.recorder

  Use the `chrome.devtools.recorder` API to customize the Recorder panel in DevTools.

  ```
  @since Chrome 105
  ```

- [x] dns

  Use the `chrome.dns` API for dns resolution.

  ```
  @alpha
  @chrome-permission dns
  @chrome-channel dev
  ```

- [ ] documentScan

  Use the `chrome.documentScan` API to discover and retrieve images from
  attached paper document scanners.

  ```
  @since Chrome 44
  @chrome-permission documentScan
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [x] dom

  Use the `chrome.dom` API to access special DOM APIs for Extensions

  ```
  @since Chrome 88
  ```

- [x] downloads

  Use the `chrome.downloads` API to programmatically initiate, monitor,
  manipulate, and search for downloads.

  ```
  @chrome-permission downloads
  ```

- [ ] enterprise.deviceAttributes

  Use the `chrome.enterprise.deviceAttributes` API to read device attributes.
  Note: This API is only available to extensions force-installed by enterprise policy.

  ```
  @since Chrome 46
  @chrome-permission enterprise.deviceAttributes
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] enterprise.hardwarePlatform

  Use the `chrome.enterprise.hardwarePlatform` API to get the manufacturer
  and model of the hardware platform where the browser runs.
  Note: This API is only available to extensions installed by enterprise policy.

  ```
  @since Chrome 71
  @chrome-permission enterprise.hardwarePlatform
  ```

- [ ] enterprise.networkingAttributes

  Use the `chrome.enterprise.networkingAttributes` API to read information about your current network.
  Note: This API is only available to extensions force-installed by enterprise policy.

  ```
  @since Chrome 85
  @chrome-permission enterprise.networkingAttributes
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] enterprise.platformKeys

  Use the `chrome.enterprise.platformKeys` API to generate keys and install
  certificates for these keys. The certificates will be managed by the platform
  and can be used for TLS authentication,
  network access or by other extension through [`chrome.platformKeys`].

  ```
  @chrome-permission enterprise.platformKeys
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [x] events

  The `chrome.events` namespace contains common types used by APIs dispatching
  events to notify you when something interesting happens.

- [x] extension

  The `chrome.extension` API has utilities that can be used by any extension page.
  It includes support for exchanging messages between an extension and its content scripts
  or between extensions, as described in detail in
  [Message Passing](https://developer.chrome.com/docs/extensions/messaging).

- [x] extensionsManifestTypes

  Schemas for structured manifest entries


- [x] extensionTypes

  The `chrome.extensionTypes` API contains type declarations for Chrome extensions.

- [ ] fileBrowserHandler

  Use the `chrome.fileBrowserHandler` API to extend the Chrome OS file browser.
  For example, you can use this API to enable users to upload files to your website.

  ```
  @chrome-permission fileBrowserHandler
  @chrome-disallow-service-workers
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] fileHandlers

  `file_handlers` manifest key defintion. File Handlers allow developers
  to let extensions interact with files on the operating system.
  This manifest key can be used by developers to register an extension to a given file type.

  ```
  @since Pending
  ```

- [ ] fileSystemProvider

  Use the `chrome.fileSystemProvider` API to create file systems,
  that can be accessible from the file manager on Chrome OS.

  ```
  @chrome-permission fileSystemProvider
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [x] fontSettings

  Use the `chrome.fontSettings` API to manage Chrome's font settings.

  ```
  @chrome-permission fontSettings
  ```

- [x] gcm

  Use `chrome.gcm` to enable apps and extensions to send and receive messages
  through [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging/) (FCM).

  ```
  @chrome-permission gcm
  ```

- [x] history

  Use the `chrome.history` API to interact with the browser's record of visited pages.
  You can add, remove, and query for URLs in the browser's history.
  To override the history page with your own version,
  see [Override Pages](https://developer.chrome.com/docs/extensions/override).

  ```
  @chrome-permission history
  ```

- [x] i18n

  Use the `chrome.i18n` infrastructure to implement internationalization across
  your whole app or extension.

- [x] identity

  Use the `chrome.identity` API to get OAuth2 access tokens.

  ```
  @chrome-permission identity
  ```

- [x] idle

  Use the `chrome.idle` API to detect when the machine's idle state changes.

  ```
  @chrome-permission idle
  ```

- [ ] incognito

  Dummy namepsace for the incognito manifest key.

  ```
  @since Chrome 87
  ```

- [ ] input.ime

  Use the `chrome.input.ime` API to implement a custom IME for Chrome OS.
  This allows your extension to handle keystrokes, set the composition,
  and manage the candidate window.

  ```
  @chrome-permission input
  @chrome-platform chromeos
  @chrome-platform win
  @chrome-platform linux
  ```

- [x] instanceID

  Use `chrome.instanceID` to access the Instance ID service.

  ```
  @since Chrome 44
  @chrome-permission gcm
  ```

- [ ] loginState

  Use the `chrome.loginState` API to read and monitor the login state.

  ```
  @since Chrome 78
  @chrome-permission loginState
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [x] management

  The `chrome.management` API provides ways to manage the list of extensions/apps
  that are installed and running. It is particularly useful for extensions that
  [override](https://developer.chrome.com/docs/extensions/override) the built-in New Tab page.

  ```
  @chrome-permission management
  ```

- [x] manifestTypes

  Schemas for structured manifest entries

- [x] mdns

  Use the `chrome.mdns` API to discover services over mDNS. This comprises
  a subset of the features of the NSD spec: http://www.w3.org/TR/discovery-api/

  ```
  @alpha
  @chrome-channel dev
  @chrome-permission mdns
  ```

- [ ] networking.onc

  The `chrome.networking.onc` API is used for configuring network connections
  (Cellular, Ethernet, VPN or WiFi). This API is available in auto-launched Chrome OS kiosk sessions.

  Network connection configurations are specified following
  [Open Network Configuration (ONC)](https://chromium.googlesource.com/chromium/src/+/main/components/onc/docs/onc_spec.md) specification.

  **NOTE**: Most dictionary properties and enum values use UpperCamelCase to
  match the ONC specification instead of the JavaScript lowerCamelCase convention.

  ```
  @alpha
  @chrome-permission networking.onc
  @chrome-channel dev
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [x] notifications

  Use the `chrome.notifications` API to create rich notifications using templates
  and show these notifications to users in the system tray.

  ```
  @chrome-permission notifications
  ```

- [x] offscreen

  Use the `offscreen` API to create and manage offscreen documents.

  ```
  @since Pending
  @chrome-permission offscreen
  @chrome-min-manifest MV3
  ```

- [x] omnibox

  The omnibox API allows you to register a keyword with Google Chrome's address bar,
  which is also known as the omnibox.

  ```
  @chrome-manifest omnibox
  ```

- [x] pageCapture

  Use the `chrome.pageCapture` API to save a tab as MHTML.

  ```
  @chrome-permission pageCapture
  ```

- [x] permissions

  Use the `chrome.permissions` API to request
  [declared optional permissions](https://developer.chrome.com/docs/extensions/reference/permissions/#manifest)
  at run time rather than install time, so users understand
  why the permissions are needed and grant only those that are necessary.

- [ ] platformKeys

  Use the `chrome.platformKeys` API to access client certificates managed by the platform.
  If the user or policy grants the permission, an extension can use such a certficate in
  its custom authentication protocol. E.g. this allows usage of platform managed certificates in
  third party VPNs (see [`chrome.vpnProvider`]).

  ```
  @since Chrome 45
  @chrome-permission platformKeys
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [x] power

  Use the `chrome.power` API to override the system's power management features.

  ```
  @chrome-permission power
  ```

- [x] printerProvider

  The `chrome.printerProvider` API exposes events used by print manager to
  query printers controlled by extensions, to query their capabilities
  and to submit print jobs to these printers.

  ```
  @since Chrome 44
  @chrome-permission printerProvider
  ```

- [ ] printing

  Use the `chrome.printing` API to send print jobs to printers installed on Chromebook.

  ```
  @since Chrome 81
  @chrome-permission printing
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] printingMetrics

  Use the `chrome.printingMetrics` API to fetch data about printing usage.

  ```
  @since Chrome 79
  @chrome-permission printingMetrics
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [x] privacy

  Use the `chrome.privacy` API to control usage of the features in Chrome that
  can affect a user's privacy. This API relies on the
  [ChromeSetting prototype of the type API](https://developer.chrome.com/docs/extensions/reference/types/#ChromeSetting)
  for getting and setting Chrome's configuration.

  ```
  @chrome-permission privacy
  ```

- [ ] processes

  Use the `chrome.processes` API to interact with the browser's processes.

  ```
  @alpha
  @chrome-permission processes
  @chrome-channel dev
  ```

- [x] proxy

  Use the `chrome.proxy` API to manage Chrome's proxy settings. This API relies on the
  [ChromeSetting prototype of the type API](https://developer.chrome.com/docs/extensions/reference/types/#ChromeSetting)
  for getting and setting the proxy configuration.

  ```
  @chrome-permission proxy
  ```

- [x] runtime

  Use the `chrome.runtime` API to retrieve the background page,
  return details about the manifest,
  and listen for and respond to events in the app or extension lifecycle.
  You can also use this API to convert the relative path of URLs to fully-qualified URLs.

- [x] scripting

  Use the `chrome.scripting` API to execute script in different contexts.

  ```
  @since Chrome 88
  @chrome-permission scripting
  @chrome-min-manifest MV3
  ```

- [x] search

  Use the `chrome.search` API to search via the default provider.

  ```
  @since Chrome 87
  @chrome-permission search
  ```

- [x] sessions

  Use the `chrome.sessions` API to query and restore tabs and windows from a browsing session.

  ```
  @chrome-permission sessions
  ```

- [x] sidePanel

  chrome.sidePanel API

  ```
  @alpha
  @chrome-permission sidePanel
  @chrome-channel canary
  @chrome-min-manifest MV3
  ```

- [ ] sockets.tcp

  Use the `chrome.sockets.tcp` API to send and receive data over the network using TCP connections.
  This API supersedes the TCP functionality previously found in the `chrome.socket` API.

  ```
  @alpha
  @chrome-manifest sockets
  @chrome-channel dev
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] sockets.tcpServer

  Use the `chrome.sockets.tcpServer` API to create server applications using TCP connections.
  This API supersedes the TCP functionality previously found in the `chrome.socket` API.

  ```
  @alpha
  @chrome-manifest sockets
  @chrome-channel dev
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] sockets.udp

  Use the `chrome.sockets.udp` API to send and receive data over the network using UDP connections.
  This API supersedes the UDP functionality previously found in the "socket" API.

  ```
  @alpha
  @chrome-manifest sockets
  @chrome-channel dev
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [x] storage

  Use the `chrome.storage` API to store, retrieve, and track changes to user data.

  ```
  @chrome-permission storage
  ```

- [x] system.cpu

  Use the `system.cpu` API to query CPU metadata.

  ```
  @chrome-permission system.cpu
  ```

- [x] system.display

  Use the `system.display` API to query display metadata.

  ```
  @chrome-permission system.display
  ```

- [x] system.memory

  The `chrome.system.memory` API.

  ```
  @chrome-permission system.memory
  ```

- [x] system.network

  Use the `chrome.system.network` API.

  ```
  @alpha
  @chrome-permission system.network
  @chrome-channel dev
  ```

- [x] system.storage

  Use the `chrome.system.storage` API to query storage device information
  and be notified when a removable storage device is attached and detached.

  ```
  @chrome-permission system.storage
  ```

- [x] tabCapture

  Use the `chrome.tabCapture` API to interact with tab media streams.

  ```
  @chrome-permission tabCapture
  @chrome-disallow-service-workers
  ```

- [x] tabGroups

  Use the `chrome.tabGroups` API to interact with the browser's tab grouping system.
  You can use this API to modify and rearrange tab groups in the browser.
  To group and ungroup tabs, or to query what tabs are in groups, use the `chrome.tabs` API.

  ```
  @since Chrome 89
  @chrome-permission tabGroups
  @chrome-min-manifest MV3
  ```

- [x] tabs

  Use the `chrome.tabs` API to interact with the browser's tab system.
  You can use this API to create, modify, and rearrange tabs in the browser.

- [x] topSites

  Use the `chrome.topSites` API to access the top sites (i.e. most visited sites)
  that are displayed on the new tab page.
  These do not include shortcuts customized by the user.

  ```
  @chrome-permission topSites
  ```

- [x] tts

  Use the `chrome.tts` API to play synthesized text-to-speech (TTS).
  See also the related [`ttsEngine`] API, which allows an extension
  to implement a speech engine.

  ```
  @chrome-permission tts
  ```

- [x] ttsEngine

  Use the `chrome.ttsEngine` API to implement a text-to-speech(TTS) engine using an extension.
  If your extension registers using this API, it will receive events containing an utterance
  to be spoken and other parameters when any extension or Chrome App uses the [`tts`] API
  to generate speech. Your extension can then use any available web technology to synthesize
  and output the speech, and send events back to the calling function to report the status.

  ```
  @chrome-permission ttsEngine
  ```

- [x] types

  The `chrome.types` API contains type declarations for Chrome.

- [ ] usb

  Use the `chrome.usb` API to interact with connected USB devices.
  This API provides access to USB operations from within the context of an app.
  Using this API, apps can function as drivers for hardware devices.
  Errors generated by this API are reported by setting [`runtime.lastError`]
  and executing the function's regular callback.
  The callback's regular parameters will be undefined in this case.

  ```
  @alpha
  @chrome-permission usb
  @chrome-channel dev
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] virtualKeyboard

  The `chrome.virtualKeyboard` API is a kiosk only API used to
  configure virtual keyboard layout and behavior in kiosk sessions.

  ```
  @alpha
  @chrome-permission virtualKeyboard
  @chrome-channel dev
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] vpnProvider

  Use the `chrome.vpnProvider` API to implement a VPN client.

  ```
  @since Chrome 43
  @chrome-permission vpnProvider
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] wallpaper

  Use the `chrome.wallpaper` API to change the ChromeOS wallpaper.

  ```
  @since Chrome 43
  @chrome-permission wallpaper
  @chrome-platform chromeos
  @chrome-platform lacros
  ```

- [ ] webAccessibleResources (since Chrome 90)

  Stub namepsace for the "web\_accessible\_resources" manifest key.

- [ ] webAuthenticationProxy

  The webAuthenticationProxy API lets remote desktop software running on
  a remote host intercept Web Authentication API (WebAuthn) requests in order
  to handle them on a local client.

  ```
  @alpha
  @chrome-permission webAuthenticationProxy
  @chrome-channel trunk
  @chrome-min-manifest MV3
  @chrome-platform win
  @chrome-platform linux
  @chrome-platform mac
  ```

- [x] webNavigation

  Use the `chrome.webNavigation` API to receive notifications about the status
  of navigation requests in-flight.

  ```
  @chrome-permission webNavigation
  ```

- [x] webRequest

  Use the `chrome.webRequest` API to observe and analyze traffic and to intercept,
  block, or modify requests in-flight.

  ```
  @chrome-permission webRequest
  ```

- [x] windows

  Use the `chrome.windows` API to interact with browser windows.
  You can use this API to create, modify, and rearrange windows in the browser.

