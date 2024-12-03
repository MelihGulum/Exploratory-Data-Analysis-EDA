import csv
import pandas as pd
import numpy as np
import time

def transform(data, year, logger):
    start_time = time.time()
    logger.info("Starting data transformation")

    try:
        if not data:
            raise ValueError("No data provided for transformation.")

        dataframe = pd.DataFrame(data)
        logger.info("DataFrame created from input data.")

        if len(data) != dataframe.shape[0]:
            raise ValueError("Row count mismatch between raw and processed data.")

        dataframe.replace('', np.nan, inplace=True)
        logger.info("Empty strings replaced with NaN.")

        # Convert specific columns to numeric, coercing errors to NaN (useful for any non-numeric entries).
        for col in ['age', 'g', 'gs', 'mp_per_g', 'fp_per_g', 'fga_per_g',
                    'fg_pct', 'fg3_per_g', 'fg3a_per_g', 'fg3_pct', 'fg2_per_g', 'fg2a_per_g', 'fg2_pct',
                    'efg_pct', 'ft_per_g', 'fta_per_g', 'ft_pct', 'orb_per_g', 'drb_per_g', 'trb_per_g',
                    'ast_per_g', 'stl_per_g', 'blk_per_g', 'tov_per_g', 'pf_per_g', 'pts_per_g']:
            dataframe[col] = pd.to_numeric(dataframe[col], errors='coerce')
        logger.info("Numeric columns converted.")


        # 1. Create a new 'season' column to mark the season year.
        dataframe.insert(loc=1, column='season', value=f'{year - 1}-{year}')
        logger.info("Season year column added.")

        # 2. Fill NaN values in percentage columns with 0.0, as some players may have missing percentages
        #    due to not attempting certain types of shots.
        dataframe[['fg3_pct', 'fg2_pct', 'ft_pct', 'fg_pct', 'efg_pct']] = dataframe[['fg3_pct', 'fg2_pct', 'ft_pct',
                                                                                      'fg_pct', 'efg_pct']].fillna(0.0)
        logger.info("NaN values in percentage columns replaced with 0.0.")

        # 3. Remove '*' characters from player names (which usually indicate retired jersey numbers).
        dataframe["player"] = dataframe['player'].str.replace('*', '')
        logger.info("Removed '*' from player names.")

        # 4. Rename the 'team_id' column to 'team' for better clarity.
        dataframe.rename(columns={'team_id': 'team'}, inplace=True)
        logger.info("Renamed 'team_id' column to 'team'.")

        # 5. Group player ages into age brackets (e.g., 18-22, 22-26, etc.).
        dataframe.insert(loc=5, column='age_group', value=pd.cut(dataframe['age'],
                                                                 bins=[17, 22, 26, 30, 34, 38, np.inf],
                                                                 labels=['18-22', '23-26', '27-30', '31-34', '35-38',
                                                                         '39+']))
        logger.info("Player ages grouped into brackets.")

        # 6. Create a new column to showing player’s decision-making ability
        dataframe['ast_tov_ratio'] = (dataframe['ast_per_g'] / dataframe['tov_per_g']).round(2)
        dataframe['ast_tov_ratio'] = dataframe['ast_tov_ratio'].replace([np.inf, -np.inf], 0)  # Replace Inf values from e.g. 4/0
        dataframe['ast_tov_ratio'] = dataframe['ast_tov_ratio'].replace(np.nan, -1) # Replace NaN comes from 0/0
        logger.info("Calculated 'ast_tov_ratio' and handled Inf and NaN values.")

        # 7. Calculate a custom efficiency metric based on various per-game stats
        dataframe['efficiency'] = ((dataframe['pts_per_g'].fillna(0)
                                    + dataframe['trb_per_g'].fillna(0)
                                    + dataframe['ast_per_g'].fillna(0)
                                    + dataframe['stl_per_g'].fillna(0)
                                    + dataframe['blk_per_g'].fillna(0))
                                    - ((dataframe['fga_per_g'].fillna(0) - dataframe['fp_per_g'].fillna(0))
                                       + (dataframe['fta_per_g'].fillna(0) - dataframe['ft_per_g'].fillna(0))
                                       + dataframe['tov_per_g'].fillna(0)
                                       + dataframe['pf_per_g'].fillna(0))
                                  ).round(2)

        end_time = time.time()
        logger.info("Data transformation completed successfully")
        logger.info(f"Data transformation duration: {end_time - start_time:.2f} seconds.")


    except ValueError as val_error:
        logger.error(f"Data validation error in: {val_error}")
        raise

    except Exception as e:
        logger.error(f"Data transformation failed: {e}")
        raise

    return dataframe