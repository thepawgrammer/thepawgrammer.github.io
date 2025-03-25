#!/bin/bash

# Get the title from the first argument
title="$1"

# Make sure the user entered a title
if [ -z "$title" ]; then
  echo "Usage: ./new_post.sh \"Post Title Here\""
  exit 1
fi

# Create filename: 2025-03-24-post-title.md
filename="$(date +%Y-%m-%d)-$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-').md"

# Create full path
filepath="_posts/$filename"

# Generate the front matter with current date and time
cat <<EOF > "$filepath"
---
title: $title
date: $(date '+%Y-%m-%d %H:%M:%S %z')
author: thepawgrammer
categories: [quantum-computing, study-notes]
tags: [quatum, computing, quantumcomputing, ibm, thepawgrammer]
---
EOF

echo "✅ New post created at: $filepath"

