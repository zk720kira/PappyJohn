# ---Imports---
import os
import pymysql
from dotenv import load_dotenv

# Charger les variables d'environnement à partir du fichier .env
load_dotenv()

# Connexion à la base de données via des variables d'environnement
try:
    connection = pymysql.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER_A"),
        password=os.getenv("DB_PASSWORD_A"),
        database=os.getenv("DB_NAME")
    )
    cursor = connection.cursor()

    # Récupérer les variables d'environnement pour d'autres utilisateurs
    users = {
        "User_B": {
                    "username": os.getenv("DB_USER_B"),
                    "password": os.getenv("DB_PASSWORD_B"),
                    "privileges": os.getenv("PRV_B")
        },
        "User_C": {
                    "username": os.getenv("DB_USER_C"),
                    "password": os.getenv("DB_PASSWORD_C"),
                    "privileges": os.getenv("PRV_C")
        },
        "User_D": {
                    "username": os.getenv("DB_USER_D"),
                    "password": os.getenv("DB_PASSWORD_D"),
                    "privileges": os.getenv("PRV_D")
        },
        "User_E": {
                    "username": os.getenv("DB_USER_E"),
                    "password": os.getenv("DB_PASSWORD_E"),
                    "privileges": os.getenv("PRV_E")
        },
    }

    table_name = os.getenv("DB_NAME")

    # Vérifier et créer les utilisateurs
    for user_key, user_info in users.items():
        user = user_info["username"]
        password = user_info["password"]
        privileges = user_info["privileges"]
        if user:
            try:
                cursor.execute("SELECT User FROM mysql.user WHERE User = %s", (user,))
                user_exist = cursor.fetchone()
                if user_exist:
                    print(f"User already exists.")
                else:
                    # Créer l'utilisateur
                    cursor.execute(f"CREATE USER '{user}'@'localhost' IDENTIFIED BY '{password}';")
                    # Accorder des privilèges spécifiques sur la table
                    cursor.execute(f"GRANT {privileges} ON table_name.* TO '{user}'@'localhost';")
                    print(f"User created and granted privileges.")
            except Exception as e:
                print(f"Error processing user: {e}")

    # Commit des modifications
    connection.commit()
except pymysql.MySQLError as e:
    print(f"Error connecting to MySQL: {e}")
finally:
    connection.close()