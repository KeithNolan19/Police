# PoloPace

A canoe polo training aid. The coach builds a session from a drill library (warm-up, sprints, lactics, passing, shooting, tactics), then runs it hands-free: the app calls each drill out loud, beeps the last three seconds, whistles on every change and announces what's next during rests, so the coach can watch the players.

The whole app is one static file, `index.html`. Sessions are saved in the browser on each device.

## Deploy / update on the droplet

Run as root on the server:

```bash
curl -fsSL https://raw.githubusercontent.com/KeithNolan19/police/main/deploy.sh | bash
```

This puts the app at `polo.vibedev.ie` in its own nginx site, leaving anything else on the server alone. Run the same command again to pull the latest version.

Before it works in a browser:
1. Add a DNS **A record** `polo` → the droplet's IP.
2. Once DNS resolves, enable HTTPS: `certbot --nginx -d polo.vibedev.ie`

## Ideas for the next version
- Installable offline app (manifest + service worker) for pools with poor signal.
- Shared sessions between club coaches (small backend + database).
- Hardware: an ESP32 driving a waterproof LED display and horn on the pool deck, synced to the app over Wi-Fi.
