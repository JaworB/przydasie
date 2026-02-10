# Virtual Environments

Managing Python dependencies with virtual environments.

## Why Virtual Environments?

- Isolated package installations
- Different projects can have different dependencies
- Avoid conflicts between projects

## Creating Virtual Environment

```bash
# Create (Python 3.3+)
python3 -m venv myenv

# Activate
source myenv/bin/activate  # Linux/macOS
myenv\Scripts\activate     # Windows

# Deactivate
deactivate
```

## Managing Packages

```bash
# Install package
pip install requests

# Install specific version
pip install requests==2.28.0

# Install from requirements.txt
pip install -r requirements.txt

# Upgrade package
pip install --upgrade requests

# Uninstall package
pip uninstall requests

# List installed packages
pip list

# Freeze requirements
pip freeze > requirements.txt
```

## requirements.txt

```txt
# requirements.txt
requests==2.28.0
numpy>=1.21.0
pandas
flask>=2.0.0
```

## Using Virtualenv (alternative)

```bash
# Install virtualenv
pip install virtualenv

# Create environment
virtualenv myenv

# Activate
source myenv/bin/activate  # Linux/macOS
myenv\Scripts\activate     # Windows

# Deactivate
deactivate

# Delete environment
rm -rf myenv
```

## Related

- [[07-Files-IO]] - Previous: Files and I/O
- [[09-Best-Practices]] - Next: Best Practices
- [[Docker-Concepts]] - Containerization with Python

## Next Steps

Proceed to [[09-Best-Practices]] to learn about coding standards.
