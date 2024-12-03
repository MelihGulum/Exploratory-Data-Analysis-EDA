import os

def create_folders(logger):
  folders = ["data/raw", "data/processed"]

  for folder in folders:
      if not os.path.exists(folder):
          os.makedirs(folder)
          logger.info(f"{folder} created!")
      else:
          logger.warning(f"{folder} already exists.")
  return folders