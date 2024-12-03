import csv
import pandas as pd
import os
import time
from ETL.src.db.database import connect_to_db, create_table, load_to_db

def load(data, processed_dataframe, file_type, year, folders, logger):
    start_time = time.time()
    logger.info("Starting to load data")

    try:
        if file_type.lower() == 'csv':
            csv_file_path = os.path.join(folders[1], f'nba_player_stats_{year}.csv')
            raw_file_path = os.path.join(folders[0], f'raw_nba_player_stats_{year}.csv')

            with open(raw_file_path, mode='w', newline='', encoding='utf-8') as raw_file:
                raw_writer = csv.DictWriter(raw_file, fieldnames=data[0].keys())
                raw_writer.writeheader()
                raw_writer.writerows(data)
            logger.info(f"Raw data has been written to {raw_file_path}")

            processed_dataframe.to_csv(csv_file_path, index=False, encoding='utf-8')
            logger.info(f"Processed data has been written to {csv_file_path}")

        elif file_type.lower() == 'mssql':
            connection = connect_to_db(logger)
            create_table(logger, connection, year)
            load_to_db(processed_dataframe, year, connection, logger)
            connection.close()

        else:
            logger.warning(f"File type {type} is not supported.")

    except FileNotFoundError as fnf_error:
        logger.error(f"File not found: {fnf_error}")
        raise

    except IOError as io_error:
        logger.error(f"I/O error: {io_error}")
        raise

    except Exception as e:
        logger.error(f"An unexpected error occurred: {e}")
        raise

    end_time = time.time()
    logger.info("Data loading completed successfully")
    logger.info(f"Data loading duration: {end_time - start_time:.2f} seconds.")