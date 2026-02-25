#!/bin/bash
flutter build ipa --release --export-method app-store --dart-define-from-file=.env/prod.json
