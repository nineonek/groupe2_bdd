import sqlite3
import os

DB_FILE = 'hospital_project.db'

CREATE_SCHEMA_FILE = 'phasetest/database_referenced.sql'
INSERT_DATA_FILE = 'groupe2_donnees.sql'

def read_sql_file(filepath):

    if not os.path.exists(filepath):
        print(f"Erreur: Le fichier SQL '{filepath}' est introuvable.")
        return None
    with open(filepath, 'r', encoding='utf-8') as f:
        return f.read()

def create_and_populate_database():

    if os.path.exists(DB_FILE):
        os.remove(DB_FILE)
        print(f"Fichier de base de données existant '{DB_FILE}' supprimé.")


    create_db_sql = read_sql_file(CREATE_SCHEMA_FILE)
    insert_data_sql = read_sql_file(INSERT_DATA_FILE)

    if create_db_sql is None or insert_data_sql is None:
        print("Impossible de continuer sans les fichiers SQL nécessaires.")
        return

    conn = None
    try:
        conn = sqlite3.connect(DB_FILE)
        cursor = conn.cursor()

        cursor.executescript(create_db_sql)
        print("Structure de la base de données créée avec succès depuis 'structure_bdd.sql'.")

        cursor.executescript(insert_data_sql)
        print("Données injectées avec succès depuis 'donnees.sql'.")

        conn.commit()
        print(f"Base de données '{DB_FILE}' créée et peuplée.")

    except sqlite3.Error as e:
        print(f"Erreur SQLite: {e}")
        if conn:
            conn.rollback() 
    finally:
        if conn:
            conn.close() 

if __name__ == "__main__":
    create_and_populate_database()
