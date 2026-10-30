# blood-website-publish - ready to upload

Upload the CONTENTS of this folder (index.html + channel.json + news.json + giscus.json + downloads/) to GitHub Pages,
Cloudflare Pages or Netlify. Full step-by-step: ../BloodClient-Publishing-Guide.md

- index.html - the website (single file, no build step; includes public GitHub-login reviews/comments through giscus + GitHub Discussions)
- downloads/ - launcher 0.3.0-beta.8 installer + the three alpha.8 jars the page links to
- channel.json - launcher auto-update file (already points at the
  BloodVapourzzz/bloodclient repo; keep it at the repo root, see guide Part 4)
- news.json - live "What's new" feed shown inside Launcher beta.8; edit the
  headline/bullets/date and re-upload this one small file to update launcher news
- giscus.json - public-review embed origins/order config; keep it in the GitHub repo root
