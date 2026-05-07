# Audio assets

Place an MP3 named **`applause.mp3`** in this directory to override the
procedural applause that plays on the supervisor podium.

The file should be at the path `/sounds/applause.mp3` from the site root,
e.g. served at `http://localhost:8080/sounds/applause.mp3`.

Recommended length: 3 to 5 seconds. Any browser-supported audio format
that decodes via the `Audio` element will work (MP3, OGG, WAV).

If the file is missing, the app falls back to a procedural applause
generated with WebAudio (multiple synthesized claps + crowd-noise layer).
