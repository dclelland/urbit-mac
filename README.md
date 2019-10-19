# urbit-mac

An Urbit client for macOS 

## Plan

1. Embed the `urbit`, `urbit-worker` binaries and `urbit-terminfo` folder in the application. Call the binary using `NSTask` and `NSPipe`.
2. Include [Bridge](https://bridge.urbit.org) for authentication/key generation. Should ideally be able to automate this and add the key to Keychain for secure access (optional biometric authentication...?). Should also look into WebKit/Ledger integration (as Safari can't handle it, need U2F extension, HTTPS connection)
3. Authenticate and start a planet with the given key
4. Open Landscape in a web view, automate authentication (are there better options than filling out the web form with the results of `+code`?)
5. Get outside feedback...

## Todo

### Project setup

- Add basic icon
- Cocoapods...?
- Keychain (or is the native keychain access good enough now that we shouldn't need this?)

### Window chrome

- Window title
- Toolbar should be inline with the traffic light buttons
- Back, forward, refresh buttons
- Address field (and spinner/loading indicator)
- Tabs (and new tab button, and tab titles) (search for 'mac tabbed application' tutorial)
- Menu items (what goes in here?)

### Web view

- Add web view
- External links should open in Safari

### Console view

- Print NSTask output to console window, add text input
- Could open in Terminal...?
- Should this just be another tab?
- Should this show while the planet is starting?

### Session management

- Think about where the planet is to be stored, how sessions are handled/persisted securely, etc
- Difference between 'new planet' and 'start existing planet'

## Other ideas

- Pier location/desk mounting?
- Updates via App Store/Sparkle
- Multiple planets/moons/comets etc...?
- Note the ames port can be specified as an argument
