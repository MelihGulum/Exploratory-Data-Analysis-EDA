import yaml
import logging.config
import os


def load_config(config_file="config/config.yaml"):
    """Load YAML config file."""
    with open(config_file, 'r') as file:
        config = yaml.safe_load(file)
    return config


def setup_logger():
    """Set up logging configuration from YAML."""
    config = load_config()

    # Ensure the log directory exists
    if not os.path.exists("log"):
        os.makedirs("log")

    logging.config.dictConfig(config['logging'])
    logger = logging.getLogger(__name__)
    return logger