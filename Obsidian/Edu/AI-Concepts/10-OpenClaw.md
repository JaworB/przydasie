# OpenClaw - Self-Hosted AI Agent

OpenClaw is an open-source personal AI assistant that runs on your own infrastructure. It connects messaging platforms (Telegram, Discord, WhatsApp, etc.) to AI coding agents.

## What is OpenClaw?

- **Personal AI agent** - Can execute tasks, manage files, browse the web, send messages
- **Self-hosted** - Runs on your own hardware (Raspberry Pi, VPS, home server)
- **Privacy-focused** - Your data stays on your machine
- **Flexible** - Connects to various LLM providers (OpenAI, Anthropic, Ollama)

## Installation

### Prerequisites

- Raspberry Pi 5 (4GB+ RAM recommended)
- Raspberry Pi OS 64-bit (Bookworm) or similar Linux
- VPN network (WireGuard recommended)

### Step 1: Install Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### Step 2: Pull a Model

Recommended models for Raspberry Pi 5:

```bash
# Smallest - fastest, limited capability
ollama pull tinyllama

# Balanced - best performance for Pi 5
ollama pull llama3.2:3b
# or
ollama pull qwen2.5:3b
```

### Step 3: Install OpenClaw

```bash
npm install -g openclaw@latest
```

### Step 4: Initial Setup

```bash
openclaw onboard --non-interactive --accept-risk
```

### Step 5: Configure Ollama Model (Corrected)

The alias approach changed in recent versions. Use the correct configuration:

```bash
# Remove any existing aliases first
openclaw models aliases remove local-ollama 2>/dev/null
```

Then update config manually. See [[#Free Model Providers]] section for full configuration.

## Running as a Service

### Create Systemd Service

Create `/etc/systemd/system/openclaw.service`:

```ini
[Unit]
Description=OpenClaw AI Assistant
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root
Environment=PATH=/root/.nvm/versions/node/v22.18.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ExecStart=/root/.nvm/versions/node/v22.18.0/bin/openclaw gateway --bind lan
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

### Enable and Start

```bash
systemctl daemon-reload
systemctl enable openclaw
systemctl start openclaw
systemctl status openclaw
```

## Access Methods

### Method 1: Direct VPN Access (Recommended)

Access the dashboard directly over VPN:

- **URL**: `http://10.66.66.3:18789` (replace with your Pi's VPN IP)
- **Token**: Check `~/.openclaw/openclaw.json` → `gateway.auth.token`

### Method 2: SSH Tunnel (Local Access)

Create SSH config at `~/.ssh/config`:

```
Host pi-gateway
    HostName 10.66.66.3
    User root
    LocalForward 18789 127.0.0.1:18789
    Port 22
```

Start tunnel:

```bash
ssh -N pi-gateway &
```

Access at: `http://127.0.0.1:18789`

## Firewall Configuration

For VPN access, configure firewall on the Pi:

```bash
# Allow localhost
iptables -I INPUT -p tcp --dport 18789 -s 127.0.0.1 -j ACCEPT

# Allow VPN network
iptables -I INPUT -p tcp --dport 18789 -s 10.66.66.0/24 -j ACCEPT

# Block everything else
iptables -A INPUT -p tcp --dport 18789 -j DROP
```

Verify rules:

```bash
iptables -L INPUT -n --line-numbers | grep 18789
```

## Troubleshooting

### VPN Connection Refused

**Problem**: Cannot connect to `http://10.66.66.3:18789`

**Solution 1**: Check if gateway is bound to all interfaces

```bash
# On Pi - check listening ports
ss -tlnp | grep 18789

# Should show: 0.0.0.0:18789
# If showing 127.0.0.1:18789, restart with --bind lan
systemctl restart openclaw
```

**Solution 2**: Verify firewall rules

```bash
# On Pi - check if rules allow your IP
iptables -L INPUT -n -v | grep 18789

# Should have ACCEPT rules for your VPN IP (e.g., 10.66.66.2)
```

**Solution 3**: Restart gateway

```bash
# On Pi
systemctl restart openclaw
sleep 3
ss -tlnp | grep 18789
```

### Gateway Timeout on Pi CLI

**Problem**: `openclaw devices list` fails with "gateway timeout"

**Cause**: Gateway bound to loopback but CLI can't connect

**Solution**: The CLI needs loopback access. Either:
1. Use SSH tunnel for CLI commands
2. Or change gateway bind mode (not recommended for security)

### Token Authentication Required

**Problem**: "unauthorized: gateway token missing"

**Solution**: 
1. Get token: `cat ~/.openclaw/openclaw.json | grep token`
2. Enter token in dashboard UI at `http://10.66.66.3:18789`
3. Or use WebSocket with token: `ws://10.66.66.3:18789?token=YOUR_TOKEN`

### Model Not Recognized / Unknown Model

**Problem**: Error: "Unknown model: http://127.0.0.1:11434/v1:llama3.2:3b"

**Cause**: Model ID includes full URL format which Ollama doesn't recognize.

**Solution**: Use proper provider format in config:

```json
{
  "models": {
    "providers": {
      "ollama": {
        "baseUrl": "http://127.0.0.1:11434/v1",
        "apiKey": "ollama-local",
        "api": "openai-completions",
        "models": []
      }
    }
  },
  "agents": {
    "defaults": {
      "models": {
        "ollama": {}
      },
      "model": {
        "primary": "ollama/llama3.2:3b"
      }
    }
  }
}
```

Then restart:
```bash
systemctl restart openclaw
```

Verify in logs:
```bash
tail -f /tmp/openclaw/openclaw-2026-*.log | grep "agent model"
```

## Device Pairing

OpenClaw uses pairing for security - unknown senders must be approved.

### Commands

```bash
# List pending pairing requests
openclaw pairing list telegram
openclaw pairing list whatsapp
openclaw pairing list discord

# Approve a device
openclaw pairing approve telegram ABC123

# Deny a device
openclaw pairing deny telegram ABC123
```

### Pairing Codes

- 8 characters, uppercase
- Excludes ambiguous characters (0, O, 1, I)
- Expires after 1 hour
- Maximum 3 pending requests per channel

## Adding Messaging Channels

### Telegram

1. Message @BotFather on Telegram
2. Create new bot (`/newbot`)
3. Get bot token
4. Configure:
```bash
openclaw channels login --channel telegram
```

### Discord

1. Go to Discord Developer Portal
2. Create application and bot
3. Get bot token
4. Enable Message Content Intent
5. Configure:
```bash
openclaw channels login --channel discord
```

## Configuration Files

- **Main config**: `~/.openclaw/openclaw.json`
- **Agents**: `~/.openclaw/agents/main/agent/`
- **Workspace**: `~/.openclaw/workspace/`
- **Logs**: `/tmp/openclaw/openclaw-YYYY-MM-DD.log`

## Free Model Providers

OpenClaw supports multiple model providers. Here are free options:

### Option 1: Ollama (Local - 100% Free)

Running locally on your Pi or computer. See [[#Ollama Configuration]] below.

### Option 2: OpenRouter (Free Tier Available)

OpenRouter provides free access to many models. No API key required for some models.

#### Configuration

Edit `~/.openclaw/openclaw.json`:

```json
{
  "models": {
    "providers": {
      "openrouter": {
        "baseUrl": "https://openrouter.ai/api/v1",
        "apiKey": "YOUR_OPENROUTER_API_KEY",
        "api": "openai-completions"
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "openrouter/NousResearch/Hermes-3-Llama-3.1-8B"
      },
      "models": {
        "openrouter/NousResearch/Hermes-3-Llama-3.1-8B": {}
      }
    }
  }
}
```

#### Recommended Free Models on OpenRouter

| Model | Description |
|-------|-------------|
| `openrouter/NousResearch/Hermes-3-Llama-3.1-8B` | Good reasoning, 8B params |
| `openrouter/NousResearch/Hermes-3-Llama-3.1-8B-LCEL` | Coding optimized |
| `openrouter/meta-llama/Llama-3.2-1B` | Small, fast |
| `openrouter/qwen/qwen2.5-3b` | Good performance |

Get free API key: https://openrouter.ai/settings/keys

### Option 3: Lynkr (Free Tier)

Another free provider option mentioned in community guides.

#### Configuration

```json
{
  "models": {
    "providers": {
      "lynkr": {
        "apiKey": "YOUR_LYNKR_API_KEY",
        "api": "openai-completions"
      }
    }
  }
}
```

### Ollama Configuration

For local Ollama models, configure in `~/.openclaw/openclaw.json`:

```json
{
  "models": {
    "providers": {
      "ollama": {
        "baseUrl": "http://127.0.0.1:11434/v1",
        "apiKey": "ollama-local",
        "api": "openai-completions",
        "models": []
      }
    }
  },
  "agents": {
    "defaults": {
      "models": {
        "ollama": {}
      },
      "model": {
        "primary": "ollama/llama3.2:3b"
      }
    }
  }
}
```

#### Recommended Ollama Models for Pi 5

| Model | Size | Description |
|-------|------|-------------|
| `llama3.2:1b` | 1.2GB | Fastest, limited capability |
| `llama3.2:3b` | 2.0GB | Balanced performance |
| `qwen2.5:3b` | 2.0GB | Good reasoning |
| `tinyllama` | 384MB | Minimal, very fast |

Note: For complex agent tasks, OpenClaw recommends models with at least 64K context. The 3B models on Pi 5 may be slow for complex reasoning tasks.

### Switching Between Providers

You can have multiple providers configured and switch by changing the `agents.defaults.model.primary` value:

```json
"model": {
  "primary": "ollama/llama3.2:3b"
}
# or
"model": {
  "primary": "openrouter/NousResearch/Hermes-3-Llama-3.1-8B"
}
```

## Security Notes

- Keep your gateway token secure
- Use pairing for all public-facing channels
- Consider running without direct network access (use SSH tunnel)
- Regularly audit with: `openclaw security audit --deep`
- Review: https://docs.openclaw.ai/gateway/security

## Resources

- [OpenClaw Documentation](https://docs.openclaw.ai/)
- [OpenClaw GitHub](https://github.com/openclaw/openclaw)
- [Official Discord](https://discord.gg/openclaw)
