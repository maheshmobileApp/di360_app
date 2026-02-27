#!/bin/bash
flutter build apk --release --dart-define-from-file=.env/dev.json
