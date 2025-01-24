#!/bin/bash

# Colors for the script
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}/------\      |------|${NC}"
echo -e "${CYAN}   |          |______|${NC}"
echo -e "${CYAN}   |          |${NC}"
echo -e "${CYAN}   |          |${NC}"
echo -e "${CYAN}Starting Localhost Web Server...${NC}"

# Generate a random port number between 8000 and 8999
PORT=$((RANDOM % 1000 + 8000))
echo -e "${GREEN}Randomized Port: $PORT${NC}"

# Create the necessary directories
if [ ! -d "uploads/photos" ]; then
    mkdir -p uploads/photos
    echo -e "${GREEN}Created directory: uploads/photos${NC}"
fi

if [ ! -d "uploads/audio" ]; then
    mkdir -p uploads/audio
    echo -e "${GREEN}Created directory: uploads/audio${NC}"
fi
echo -e "${GREEN}Server is running at http://127.0.0.1:$PORT${NC}"
# Check for the custom HTML file
if [ -f "index.html" ]; then
    echo -e "${GREEN}Custom index.html file found. Using it for the web server.${NC}"
else
    echo -e "${RED}Custom index.html not found! Please ensure it's in the same directory as the script.${NC}"
    exit 1
fi

# Create the PHP file to handle uploads
cat << 'EOF' > upload.php
<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_FILES['photo'])) {
        $fileName = 'uploads/photos/' . $_FILES['photo']['name'];
        move_uploaded_file($_FILES['photo']['tmp_name'], $fileName);
    } elseif (isset($_FILES['audio'])) {
        $fileName = 'uploads/audio/' . $_FILES['audio']['name'];
        move_uploaded_file($_FILES['audio']['tmp_name'], $fileName);
    }
}
?>
EOF

# Start the PHP server with the randomized port
php -S 127.0.0.1:$PORT


echo -e "${RED}Press Ctrl+C to stop the server.${NC}"
