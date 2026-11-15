# TLP Configuration (ThinkPad E16 Gen 2)

Custom drop-in configuration for TLP 1.11 (`/etc/tlp.d/10-custom.conf`) tailored for the Waybar 3-state profile toggle (`tlp-profile-toggle.sh`).

## Profile Matrix

| Metric | Performance (󰓅) | Balanced (󰾅) | Power-Saver (󰾆) |
| :--- | :--- | :--- | :--- |
| **Governor** | `powersave` | `powersave` | `powersave` |
| **EPP Policy** | `performance` | `balance_power` | `power` |
| **Max Frequency** | 4.5 GHz | 4.5 GHz | 1.2 GHz (Base) |
| **Turbo Boost (`no_turbo`)** | `0` (Allowed) | `0` (Allowed) | `1` (Disabled) |
| **HWP Dynamic Boost** | `1` (On) | `0` (Off) | `0` (Off) |
| **Platform Profile** | `performance` | `balanced` | `low-power` |

## Deployment

Symlinked directly to the system drop-in directory:

```bash
sudo ln -sf "$HOME/.config/tlp/10-custom.conf" /etc/tlp.d/10-custom.conf
```
