import pyodbc
import os
import pandas as pd
import numpy as np
from ETL.src.utils.config_loader import load_config


def connect_to_db(logger):
    """Connect to the database using configuration from YAML file."""

    # Load the YAML configuration
    config = load_config()
    db_config = config['database']

    try:
        # Connect to the SQL Server using the configuration
        connection = pyodbc.connect(DRIVER=f'{{{db_config["driver"]}}}',  # Wrap driver name in curly braces
                                    SERVER=db_config['server'],
                                    PORT=db_config['port'],
                                    DATABASE=db_config['database'],
                                    Trusted_Connection=db_config['trusted_connection'])
        connection.autocommit = True
        logger.info(f"Connected to SQL Server")
        return connection
    except Exception as e:
        logger.error(f"Error connecting to the database: {e}")
        return None


def create_table(logger, connection, year):
    """Create the table for storing NBA player statistics for a specific year."""
    cursor = connection.cursor()

    # SQL to create the table
    create_table_query = f"""
    DROP TABLE IF EXISTS nba_player_stats_{year};

    CREATE TABLE nba_player_stats_{year} (
        id INT IDENTITY(1, 1) PRIMARY KEY,
        ranker INT,
        season VARCHAR(255),
        player VARCHAR(255),
        pos VARCHAR(255),
        age INT,
        age_group VARCHAR(255),
        team VARCHAR(255),
        games_played INT,
        games_started INT,
        minutes_per_game FLOAT,
        field_goals_made_per_game FLOAT,
        field_goals_attempted_per_game FLOAT,
        field_goal_percentage FLOAT,
        three_pointers_made_per_game FLOAT,
        three_pointers_attempted_per_game FLOAT,
        three_point_percentage FLOAT,
        two_pointers_made_per_game FLOAT,
        two_pointers_attempted_per_game FLOAT,
        two_point_percentage FLOAT,
        effective_field_goal_percentage FLOAT,
        free_throws_made_per_game FLOAT,
        free_throws_attempted_per_game FLOAT,
        free_throw_percentage FLOAT,
        offensive_rebounds_per_game FLOAT,
        defensive_rebounds_per_game FLOAT,
        total_rebounds_per_game FLOAT,
        assists_per_game FLOAT,
        steals_per_game FLOAT,
        blocks_per_game FLOAT,
        turnovers_per_game FLOAT,
        personal_fouls_per_game FLOAT,
        points_per_game FLOAT,
        ast_tov_ratio FLOAT,
        efficiency FLOAT
    );
    """

    try:
        cursor.execute(create_table_query)
        connection.commit()
        logger.info(f"Table for year {year} created successfully!")
    except Exception as e:
        logger.error(f"Error creating table for year {year}: {e}")
        connection.rollback()


def load_to_db(cleaned_dataframe, year, connection, logger):
    """Load cleaned data into the database for a specific year."""
    cursor = connection.cursor()
    logger.info(f"Starting to load data for year {year} into the database")

    try:
        for _, row in cleaned_dataframe.iterrows():
            row = row.where(pd.notnull(row), None) # Convert NaN to None
            
            cursor.execute(f"""
                INSERT INTO nba_player_stats_{year} (
                    ranker,
                    season,
                    player,
                    pos,
                    age,
                    age_group,
                    team,
                    games_played,
                    games_started,
                    minutes_per_game,
                    field_goals_made_per_game,
                    field_goals_attempted_per_game,
                    field_goal_percentage,
                    three_pointers_made_per_game,
                    three_pointers_attempted_per_game,
                    three_point_percentage,
                    two_pointers_made_per_game,
                    two_pointers_attempted_per_game,
                    two_point_percentage,
                    effective_field_goal_percentage,
                    free_throws_made_per_game,
                    free_throws_attempted_per_game,
                    free_throw_percentage,
                    offensive_rebounds_per_game,
                    defensive_rebounds_per_game,
                    total_rebounds_per_game,
                    assists_per_game,
                    steals_per_game,
                    blocks_per_game,
                    turnovers_per_game,
                    personal_fouls_per_game,
                    points_per_game,
                    ast_tov_ratio,
                    efficiency
                ) VALUES (
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 
                    ?, ?, ?, ?
                );
            """, (
                row['ranker'],
                row['season'],
                row['player'],
                row['pos'],
                row['age'],
                row['age_group'],
                row['team'],
                row['g'],  # games played
                row['gs'],  # games started
                row['mp_per_g'],  # minutes per game
                row['fp_per_g'],  # field goals made per game
                row['fga_per_g'],  # field goals attempted per game
                row['fg_pct'],  # field goal percentage
                row['fg3_per_g'],  # three-pointers made per game
                row['fg3a_per_g'],  # three-pointers attempted per game
                row['fg3_pct'],  # three-point percentage
                row['fg2_per_g'],  # two-pointers made per game
                row['fg2a_per_g'],  # two-pointers attempted per game
                row['fg2_pct'],  # two-point percentage
                row['efg_pct'],  # effective field goal percentage
                row['ft_per_g'],  # free throws made per game
                row['fta_per_g'],  # free throws attempted per game
                row['ft_pct'],  # free throw percentage
                row['orb_per_g'],  # offensive rebounds per game
                row['drb_per_g'],  # defensive rebounds per game
                row['trb_per_g'],  # total rebounds per game
                row['ast_per_g'],  # assists per game
                row['stl_per_g'],  # steals per game
                row['blk_per_g'],  # blocks per game
                row['tov_per_g'],  # turnovers per game
                row['pf_per_g'],  # personal fouls per game
                row['pts_per_g'],  # points per game
                row['ast_tov_ratio'],
                row['efficiency']
            ))
        connection.commit()
        logger.info(f"Data for year {year} successfully loaded into the database")
    except Exception as e:
        connection.rollback()
        logger.error(f"Error loading data for year {year} into the database: {e}")
        raise

