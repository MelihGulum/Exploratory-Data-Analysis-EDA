from ETL.src.etl.extract import extract_player_data
from ETL.src.etl.transform import transform
from ETL.src.etl.load import load
from ETL.src.utils.create_folders import create_folders
from ETL.src.utils.config_loader import setup_logger
import time


def main(start_year, end_year, concat=False):
  logger = setup_logger()
  folders = create_folders(logger)
  etl_start_time = time.time()

  for year in reversed(range(start_year, (end_year + 1))):
      start_time = time.time()
      logger.info(f"The ETL process for {year} has started.")

      year = str(year)
      URL = f'https://www.basketball-reference.com/leagues/NBA_{year}_per_game.html'
      extracted_data = extract_player_data(URL, year, logger)
      df = transform(extracted_data, int(year), logger)
      load(extracted_data, df,  'csv', year, folders, logger)

      end_time = time.time()
      logger.info(f"The ETL process duration for {year}: {end_time - start_time:.2f} seconds.")

  if concat:
      for folder in ["data/processed", "data/raw"]:
          filepaths = [os.path.join(folder, f) for f in os.listdir(folder) if f.endswith('.csv')]
          pd.concat(map(pd.read_csv, sorted(filepaths))).reset_index(drop=True, names='id').to_csv(os.path.join('data', f'{folder.split("/")[1]}_nba_players_{start_year}-{end_year}.csv'))
          logger.info(f'{folder.split("/")[1]} csv files habe been concatenated and has been saved in data folder.')

  etl_end_time = time.time()
  logger.info("ETL process has been finished.")
  logger.info(f"ETL process duration: {etl_end_time - etl_start_time:.2f} seconds.")


if __name__ == "__main__":
  main(1960, 1961)