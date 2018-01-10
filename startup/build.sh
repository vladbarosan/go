
#!/usr/bin/env bash
docker run --rm -v $(pwd):/src -w /src golang:1.9.2 /bin/bash -c "go build -o defaultstaticwebapp"