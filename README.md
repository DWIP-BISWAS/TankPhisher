
# TankPhisher V1.0.0

TankPhisher is a powerful camera and microphone phishing tool designed for educational and testing purposes. This project is currently in development, so there might be some bugs. Stay tuned for future updates!
## ⚠️ Disclaimer

This project is intended for educational purposes only. Any misuse or unauthorized activity with this tool is strictly prohibited and may lead to legal consequences. Use responsibly.
## 🔧 Features
Real-Time Audio and Image Capture: Starts collecting audio and image files once the victim interacts with the phishing link.

Cloudflared Integration: Generates a permanent URL to share with the target.

Simple Setup: Minimal commands to get the tool running.
## 🚀 Installation & Usage
Follow these steps to set up and use TankPhisher:

## 1.Install Termux

Install Termux from PlayStore, F-Droid

Now update and upgrade your Termux 

```bash
apt update
apt upgrade
```

## 2. Run Locally

Clone the project

```bash
  git clone https://github.com/DWIP-BISWAS/TankPhisher
```

Go to the project directory

```bash
  cd TankPhisher
```

Grant Execution Permission

```bash
  chmod +x ps.sh
```

Install Cloudflared

Check for latest release in there own repository

```bash
  pkg install wget  
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm  
chmod +x cloudflared-linux-arm  
mv cloudflared-linux-arm $PREFIX/bin/cloudflared

```
Run the script

```bash
./ps.sh
```
Obtain the Localhost URL

```bash
After running the script, you will receive an HTTP localhost address (e.g., http://127.0.0.1:8080).
```

Set Up the Cloudflared Tunnel

Open a new Termux session and run the following command:

```bash
cloudflared tunnel --url <local_host_url>

Replace <local_host_url> with the localhost address you received earlier (e.g., http://127.0.0.1:8080).
```

Share the Permanent URL

```bash
Once the Cloudflared tunnel is active, you will receive a permanent URL. Share this link with the target.
```





## 🛠️ Development Phase

This tool is still under development. Some features may not work as intended, and there could be bugs. Please report any issues or suggestions through the repository's Issues section.
