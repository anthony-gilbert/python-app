
# Python App

A lightweight Python application built to demonstrate core features, including setup, execution, and configuration.

##  Features

- Modular Python code structure
- Configurable via environment variables
- Easy to run locally or in containers
- Simple logging for debugging

##  Requirements

- Python 3.9+
- pip (Python package manager)
- (Optional) Docker

##  Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/python-app.git
cd python-app
pip install -r requirements.txt
python main.py
python main.py --config config.yaml
```
Configure
```bash
APP_ENV=development
LOG_LEVEL=INFO
```

##  Docker

Build and run:

```bash
docker build -t python-app .
docker run --rm -it python-app
```
