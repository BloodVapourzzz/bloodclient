# Deploying Blood Client to GitHub Pages

1. Upload the *contents* of this folder so `index.html` is at the repository root and `downloads/` sits beside it.
2. In the repository, open **Settings → Pages**. Choose **Deploy from a branch**, then `main` and `/(root)`.
3. Save and wait for the Pages deployment to finish.

The site uses relative `./downloads/...` links. Keep the download paths intact when uploading. This pack includes the launcher installer, certificate helper and three client jars. The installer is about 87 MB, below GitHub's 100 MB single-file limit. If adding larger optional files, use GitHub Releases.

To use a custom domain, rename `CNAME.example` to `CNAME` and put one hostname in it.
