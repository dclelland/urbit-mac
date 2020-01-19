# urbit-mac

An Urbit client for macOS 

## Paper notes

- Menu commands (which of these should also be in the toolbar?):
    - New: Should be able to create a new planet (with options for fake, comet, keyfile etc)
    - Run: Should be able to run an existing planet (Existing menu items 'Open', 'Open Recent')
    - Connect: Should have a menu command to open a terminal connected to the current process

- Simple welcome screen: new ship/fakeship/comet, run existing ship
    - Don't show this at startup checkbox

- Implement proper web browser + progress controls etc
    - Actually hook up back/forward buttons
    - Enable the gesture to go back
    - Note: Refresh button in window toolbar connected to first responder's `refresh:` action
    - Design ideas: Should display ship name etc in address bar? Needs more thought, probably a custom address bar control

- Authentication: as separate from Bridge - can we just pull the `+code` out of the client somehow/add to cookies(?)/modify request? Reverse engineer what the web client does

- Persistence: How should this work; what should it store; what authentication (biometric?) is required?

- Piping: Process should be able to print stdout/stderr

- Sort out lock file issue; it's causing OODA loop problems. Does the process need to be interrupted correctly on program termination? Try the notification center
    - Could have proper ship process pool; each ship should have at least one window; confirmation dialog on final window close (override `applicationShouldTerminate:`)

- Web view needs to open only after planet has launched; Display port output while loading...?

- Key commands don't work when the web view is focused...?

- Refactor Process handling to make run async

- Ames port stuff
 
- Tabbed window management
    - One ship per window; should prevent tabs with ships from sharing same parent window
    - Planet name in title...?
    - Sigil in window...?
 
- Bridge: Long term, but need to look into embedding bridge, or in the meantime redirecting the user to the official bridge so they can download their keyfile

- Proper ames client interface

- Proper clay desk mounting?

## Plan

1. Embed the `urbit`, `urbit-worker` binaries and `urbit-terminfo` folder in the application. Call the binary using `NSTask` and `NSPipe`.
2. Include [Bridge](https://bridge.urbit.org) for authentication/key generation. Should ideally be able to automate this and add the key to Keychain for secure access (optional biometric authentication...?). Should also look into WebKit/Ledger integration (as Safari can't handle it, need U2F extension, HTTPS connection)
3. Authenticate and start a planet with the given key
4. Open Landscape in a web view, automate authentication (are there better options than filling out the web form with the results of `+code`?)
5. Get outside feedback...

## Todo

### Now

- Open Landscape in browser window (http://localhost:8080)
- See about pier location configuration (+ an 'open pier' dialog?)
- Set up async tasks, pipe/pipe error handling and printing
- Think about UX flow

### Window chrome

- Window title
- Toolbar should be inline with the traffic light buttons
- Back, forward, refresh buttons
- Address field (and spinner/loading indicator)
- Tabs (and new tab button, and tab titles) (search for 'mac tabbed application' tutorial; multiple windows)
- Menu items (what goes in here?)

### Web view

- External links should open in Safari

### Console view

- Print NSTask output to console window, add text input
- Could open in Terminal...?
- Should this just be another tab?
- Should this show while the planet is starting?
- See: `con` command on the new Haskell client

### Session management

- Think about where the planet is to be stored, how sessions are handled/persisted securely, etc
- Difference between 'new planet' and 'start existing planet'
- Install Keychain pod (or is the native keychain access good enough now that we shouldn't need this?)

## Other ideas

- Pier location/desk mounting?
- Set up the pill
- Updates via App Store/Sparkle
- Multiple planets/moons/comets etc...? Note the ames port can be specified as an argument, should just increment
- Fix sandboxing: `urbit` wants to write to `/tmp`
