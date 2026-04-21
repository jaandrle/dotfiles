# Toolchain Configuration

Development tool configurations including aliases and environment managers.

## Files

- `index.sh` - Main entry point
- `aliases.sh` - Comprehensive aliases collection (grouped by functionality)
- `brew.sh` - Homebrew setup
- `cross-session/` - Cross-session variable management system:
  - `index.sh` - Entry point
  - `store.sh` - Storage for cross-session variables
- `jaaenv.sh` - Custom environment management (Java, Node.js, PHP, Gradle)
- `nvm-node.sh` - Node/nvm setup
- `portkiller/` - Port killer utility (git submodule)
- `sdkman.sh` - SDKMAN setup
- `tv.sh` - television (completition) setup
- `vifm.sh` - VIFM replaced via this

## Organization

- **Color/UX settings**: Located in `shell/ux.sh`
- **Cross-session management**: Now in `cross-session/` subdirectory
- **Aliases**: Grouped in `aliases.sh` by functionality:
  - System aliases (ls, grep, etc.)
  - Git and version control
  - Utility functions
  - Network utilities
  - Node.js tools
  - RPG utilities
  - Process management
- **Environment management**: Split across specialized files:
  - `jaaenv.sh` - Main environment system
  - `nvm-node.sh` - Node.js version management
  - `sdkman.sh` - SDKMAN management

## Important Notes

- Contains development tools and shortcuts
- Environment managers handle Java, Node.js, PHP, Gradle versions
- Automatically sourced by main `.bashrc`
