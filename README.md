# R6 Animations

A compact Roblox Luau animation panel for R6 avatars with a draggable Onyx-style interface and a collection of classic animations.

## Preview

<img width="767" height="435" alt="R6 Animations interface" src="https://github.com/user-attachments/assets/7dc8b2b9-2b8b-47f8-b5be-cd094df79d77" />

## Usage

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/zvzt/R6Anims.lua/refs/heads/main/r6anims.lua"))()
```

## Features

- Draggable Onyx-style interface
- Header-only minimize/restore behavior
- Screen-edge drag clamping
- One-click animation toggling
- Automatic character and Animator refresh handling
- 30+ classic R6 animations
- Rerun-safe UI replacement

## UI

The current interface uses the same dark Onyx styling as the rest of the tool set:

- 10 px rounded window
- Thin dark border
- 38 px header
- Minimize collapses the window to the header instead of spawning a separate mini window
- Standard drag bounds use a `-57` top offset and `57` bottom offset

## Compatibility

- Intended for Roblox R6 avatars
- Requires an environment that supports `loadstring` and `game:HttpGet` when using the one-line loader
- Animation availability can depend on Roblox asset permissions and platform changes

## Files

- `r6anims.lua` — main script
- `README.md` — documentation

## License

MIT — see [LICENSE](LICENSE).
