# Thomas Rüegg
import os

from flask import request, jsonify, Flask, render_template, redirect, url_for, session

import secrets

import pymysql

from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.engine import cursor

app = Flask(__name__)
app.secret_key = secrets.token_hex(16)  # Génère une clé secrète aléatoire de 32 caractères
app.config["UPLOAD_FOLDER"] = "static"

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql://root:@localhost:3306/ruegg_thomas_expi1b_pappy_john"
db = SQLAlchemy(app)


class Data(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    # Définition des autres champs de la table


# Fonction pour trier les données de commandes par numéro de commande
def sort_cmd_data(data, order):
    return sorted(data, key=lambda x: int(x[0]), reverse=(order == 'DESC'))


# Route pour afficher les données dans une page HTML
@app.route('/')
def afficher_donnees():
    try:
        connection = pymysql.connect(host=os.getenv("DB_HOST"),
                                     user=os.getenv("DB_USER_A"),
                                     password=os.getenv("DB_PASSWORD"),
                                     database=os.getenv("DB_NAME"))
        cursor = connection.cursor()
    except Exception as e:
        return """<h1><center>La connexion à la base de données a échoué !</h1>
               <br>
               <h2>Astuces :</h2>
               <ol>
               <li>Veuillez contrôler que le serveur MySQL / base de données soit démarré !</li>
               <li>Veuillez redémarrer le serveur MySQL / base de données !</li>
               <li>Veuillez contacter : <a href='mailto:'>totozk720@gmail.com</li>
               </ol>
               """

    # Utilisation de try pour éviter des exceptions avec des query SQL
    try:
        # Requête pour obtenir les données des commandes
        cursor.execute("""
                        SELECT cmd.CmdNo_Commande, cmd.Id_commande, fourn.Id_Fourn, art.Id_article, art.ArtArticle, art.ArtVariante, art.ArtQuantite, cmd.CmdPers_passe_Cmd, cmd.CmdStatus, 
                        DATE_FORMAT(cmd.CmdCommande_le, '%d.%m.%Y'), DATE_FORMAT(cmd.CmdRecu_le, '%d.%m.%Y'),
                        cmd.CmdRemarque, fourn.FournNom_fournisseur, art.ArtNo_Article
                        FROM tblcommande AS cmd
                        INNER JOIN tblcmd_art AS ca
                        ON cmd.Id_commande = ca.Fk_Cmd
                        INNER JOIN tblarticle AS art
                        ON ca.Fk_Art = art.Id_article
                        INNER JOIN tblcmd_fourn AS cf
                        ON cmd.Id_commande = cf.Fk_Cmd
                        INNER JOIN tblfournisseur AS fourn
                        ON cf.Fk_Fourn = fourn.Id_Fourn;
                        """)
        query_data = cursor.fetchall()

        # Récupérer l'ordre de tri à partir des paramètres de la requête
        order = request.args.get('order', 'ASC')

        # Trier les données selon l'ordre spécifié
        sorted_data = sort_cmd_data(query_data, order)

        # Inverser l'ordre de tri pour la prochaine requête
        if order == 'ASC':
            next_order = 'DESC'
        else:
            next_order = 'ASC'

        # Trier les données selon l'ordre spécifié
        sorted_data = sort_cmd_data(query_data, order)

    except Exception as e:
        connection.rollback()
        print("Erreur lors de l'insertion : ", e)

    try:
        # Récupérer les fournisseurs éxistant pour la liste déroulante
        cursor.execute("""
                        SELECT DISTINCT FournNom_fournisseur FROM tblfournisseur
                        """)
        fournisseur_data = cursor.fetchall()
    except Exception as e2:
        connection.rollback()
        print("Erreur lors de l'insertion : ", e2)

    try:
        # Récupérer les données sur les fournisseurs
        cursor.execute("""
                           SELECT DISTINCT fourn.FournNom_fournisseur, fourn.Fourn_domaine_vente, cont.ContNo_telephone,
                           cont.ContMail
                           FROM tblfournisseur AS fourn
                           INNER JOIN tblfourn_cont AS fc
                           ON fourn.Id_Fourn = fc.Fk_Fourn
                           INNER JOIN tblcontact AS cont
                           ON fc.Fk_Cont = cont.Id_contact;
                          """)
        fournisseur = cursor.fetchall()
    except Exception as e3:
        connection.rollback()
        print("Erreur lors de l'insertion : ", e3)

    try:
        # Récupérer l'ID et le numéro des commandes pour les affichers dans le popup pour supprimer et modifier les commandes
        cursor.execute("SELECT Id_commande, CmdNo_Commande FROM tblcommande")
        RemoveModify_data = cursor.fetchall()
    except Exception as e4:
        connection.rollback()
        print("Erreur lors de l'insertion : ", e4)

    try:
        # Récupérer l'ID des commandes pour la liste déroulante dans le popup pour supprimer et modifier les commandes
        cursor.execute("SELECT Id_commande FROM tblcommande")
        selected_cmd_id = cursor.fetchall()
    except Exception as e5:
        connection.rollback()
        print("Erreur lors de l'insertion : ", e5)

    try:
        return render_template("index.html", query_data=sorted_data, order=order, next_order=next_order,
                               fournisseur_data=fournisseur_data, fournisseur=fournisseur,
                               RemoveModify_data=RemoveModify_data, selected_cmd_id=selected_cmd_id, )
    except Exception as e8:
        connection.rollback()
        print("Erreur lors de l'insertion : ", e8)
    finally:
        connection.close()


# Insréer des nouvelles commandes
@app.route("/insert_data", methods=['POST'])
def insert_data():
    if request.method == 'POST':
        # Réqupérer les données
        no_commande = request.form['no_commande']
        article = request.form['article']
        variante = request.form['variante']
        quantite = request.form['quantite']
        commande_par = request.form['commande_par']
        statut = request.form['statut']
        commande_le = request.form['commande_le']
        recu_le = request.form['recu_le']
        remarque = request.form['remarque']
        no_article = request.form['no_article']
        fournisseur = request.form['fournisseur']

        connection = pymysql.connect(host=os.getenv("DB_HOST"),
                                     user=os.getenv("DB_USER_C"),
                                     password=os.getenv("DB_PASSWORD_C"),
                                     database=os.getenv("DB_NAME"))
        cursor = connection.cursor()

        # Utilisation de try pour se protéger des exceptions des query SQL
        try:
            # Insérer les données dans la table tblarticle
            sql_article = ("INSERT INTO tblarticle(ArtArticle, ArtVariante, ArtQuantite,"
                           "ArtNo_Article) VALUES (%s, %s, %s, %s)")
            cursor.execute(sql_article, (article, variante, quantite, no_article))
            article_id = cursor.lastrowid  # Récupérer l'ID inséré

            # Insérer les données dans la table tblcommande
            sql_commande = ("INSERT INTO tblcommande(CmdNo_Commande, CmdPers_passe_Cmd, CmdStatus, CmdCommande_le,"
                            "CmdRecu_le, CmdRemarque) VALUES (%s, %s, %s, %s, %s, %s)")
            cursor.execute(sql_commande, (no_commande, commande_par, statut, commande_le, recu_le, remarque))
            commande_id = cursor.lastrowid  # Récupérer l'ID inséré

            # Récupérer l'ID du fournisseur séléctionner dans le formulaire
            cursor.execute("SELECT Id_Fourn FROM tblfournisseur WHERE FournNom_fournisseur = %s", fournisseur)
            row = cursor.fetchone()
            fournisseur_id = row[0]

            # Insérer les données dans la table tblcmd_fourn avec l'ID du fournisseur
            sql_cmd_fourn = "INSERT INTO tblcmd_fourn(Fk_Cmd, Fk_Fourn) VALUES (%s, %s)"
            cursor.execute(sql_cmd_fourn, (commande_id, fournisseur_id))

            # Insérer les données dans la table tblcmd_art
            sql_cmd_art = "INSERT INTO tblcmd_art(Fk_Cmd, Fk_Art) VALUES (%s, %s)"
            cursor.execute(sql_cmd_art, (commande_id, article_id))

            connection.commit()
            return redirect(url_for('afficher_donnees'))
        except Exception as e:
            connection.rollback()
            print("Erreur lors de l'insertion : ", e)
        finally:
            connection.close()


# Insérer des nouveaux fournisseurs
@app.route("/insert_data_fournisseur", methods=['POST'])
def insert_data_fournisseur():
    if request.method == 'POST':
        # Récupérer les données
        nom = request.form['nom']
        domaine_vente = request.form['domaine_vente']
        email = request.form['email']
        tel = request.form['tel']

        connection = pymysql.connect(host=os.getenv("DB_HOST"),
                                     user=os.getenv("DB_USER_C"),
                                     password=os.getenv("DB_PASSWORD_C"),
                                     database=os.getenv("DB_NAME"))
        cursor = connection.cursor()

        # Utilisation de try pour se protéger des exceptions des query SQL
        try:
            # Insérer les données dans la table tblfournisseur
            sql_fournisseur = "INSERT INTO tblfournisseur(FournNom_fournisseur, Fourn_domaine_vente) VALUES (%s, %s)"
            cursor.execute(sql_fournisseur, (nom, domaine_vente))
            fournisseur_id = cursor.lastrowid  # Récupérer l'ID du fournisseur inséré

            # Inésrer les données dans la table tblcontact
            sql_contact = "INSERT INTO tblcontact(ContNo_telephone, ContMail) VALUES (%s, %s)"
            cursor.execute(sql_contact, (tel, email))
            contact_id = cursor.lastrowid  # Récupérer l'ID du contact inséré

            # Insérer les données dans la table tblfourn_cont
            sql_fourn_cont = "INSERT INTO tblfourn_cont(Fk_Fourn, Fk_cont) VALUES (%s, %s)"
            cursor.execute(sql_fourn_cont, (fournisseur_id, contact_id))

            connection.commit()
            return redirect(url_for('afficher_donnees'))
        except Exception as e:
            connection.rollback()
            print("Erreur lors de l'insertion : ", e)
        finally:
            connection.close()


# Route pour traiter les actions des commandes
@app.route('/handle_action', methods=['POST'])
def handle_action():
    data = request.get_json()
    id_commande = data.get('id')
    id_fourn = data.get('id_fourn')
    id_article = data.get('id_article')
    content = data.get('content')
    article = data.get('article')
    quantity = data.get('quantity')
    command_by = data.get('command_by')
    action = data.get('action')

    # Si l'action est delete, on supprime la commande
    if action == 'delete':
        # Connexion à la base de données
        connection = pymysql.connect(host=os.getenv("DB_HOST"),
                                     user=os.getenv("DB_USER_A"),
                                     password=os.getenv("DB_PASSWORD_A"),
                                     database=os.getenv("DB_NAME"))
        cursor = connection.cursor()

        # Requête SQL pour supprimer la commande
        try:
            # Désactiver temporairement les contraintes de clé étrangère
            cursor.execute("SET FOREIGN_KEY_CHECKS = 0")

            # Déplacer les données dans une table "poubelle"
            move = ("""
                        INSERT INTO tblsarlacc1 (SANo_commande, SAArticle, SAVariante, SAQuantite, SACommande_par,
                                                SAStatut, SACommande_le, SARecu_le, SARemarque,
                                                SANo_article, SALiaison_fournisseur)
                        SELECT cmd.CmdNo_Commande, art.ArtArticle, art.ArtVariante, art.ArtQuantite,
                        cmd.CmdPers_passe_Cmd, cmd.CmdStatus, cmd.CmdCommande_le, cmd.CmdRecu_le,
                        cmd.CmdRemarque, art.ArtNo_Article, CF.Fk_fourn
                        FROM tblcmd_fourn AS CF
                        JOIN tblcommande AS cmd ON CF.Fk_Cmd = cmd.Id_commande
                        JOIN tblcmd_art AS CA ON cmd.Id_commande = CA.Fk_Cmd
                        JOIN tblarticle AS art ON CA.Fk_Art = art.Id_article
                        WHERE cmd.CmdNo_Commande = %s AND art.ArtArticle = %s AND art.ArtQuantite = %s
                        AND cmd.CmdPers_passe_Cmd = %s;
                        """)
            cursor.execute(move, (content, article, quantity, command_by))

            # Supprimer les données une fois qu'elles ont été déplacées dans la table "poubelle"
            remove = ("""
                        DELETE CF, CA, cmd, art
                        FROM tblcmd_fourn AS CF
                        JOIN tblcommande AS cmd ON CF.Fk_Cmd = cmd.Id_commande
                        JOIN tblcmd_art AS CA ON cmd.Id_commande = CA.Fk_Cmd
                        JOIN tblarticle AS art ON CA.Fk_Art = art.Id_article
                        WHERE cmd.CmdNo_Commande = %s AND art.ArtArticle = %s AND art.ArtQuantite = %s
                        AND cmd.CmdPers_passe_Cmd = %s;
                        """)
            cursor.execute(remove, (content, article, quantity, command_by))

            # Réactiver les contraintes de clé étrangère
            cursor.execute("SET FOREIGN_KEY_CHECKS = 1")

            connection.commit()
            return jsonify({'message': 'Commande supprimé avec succès !'})
        except Exception as e:
            connection.rollback()
            return jsonify({'message': 'Une erreur est survenue lors de la suppression des données'})
        finally:
            connection.close()

    # Si l'action est update, on modifie la commande
    elif action == 'update':
        connection = pymysql.connect(host=os.getenv("DB_HOST"),
                                     user=os.getenv("DB_USER_B"),
                                     password=os.getenv("DB_PASSWORD_B"),
                                     database=os.getenv("DB_NAME"))
        cursor = connection.cursor()

        try:
            # Stocker les id dans la session flask
            session['id_commande'] = id_commande
            session['id_fourn'] = id_fourn
            session['id_article'] = id_article

            # Récupérer les types de données des colonnes
            cursor.execute("""
                SELECT 
                    c.COLUMN_NAME,
                    c.DATA_TYPE
                FROM
                    INFORMATION_SCHEMA.COLUMNS c
                WHERE
                    c.TABLE_NAME IN ('tblcommande', 'tblcmd_art', 'tblarticle', 'tblcmd_fourn', 'tblfournisseur')
                    AND c.COLUMN_NAME IN ('CmdNo_Commande', 'ArtArticle', 'ArtVariante', 'ArtQuantite', 'CmdPers_passe_Cmd',
                                            'CmdStatus', 'CmdCommande_le', 'CmdRecu_le',
                                            'CmdRemarque', 'FournNom_fournisseur', 'ArtNo_Article')
                    AND c.TABLE_SCHEMA = 'ruegg_thomas_expi1b_pappy_john'
                    ORDER BY FIELD(c.COLUMN_NAME, 'CmdNo_Commande', 'ArtArticle', 'ArtVariante', 'ArtQuantite',
                                    'CmdPers_passe_Cmd','CmdStatus', 'CmdCommande_le', 'CmdRecu_le',
                                    'CmdRemarque', 'FournNom_fournisseur', 'ArtNo_Article');
            """)
            column_types = cursor.fetchall()

            # Requete SQl pour séléctionner les données pour la modification
            cursor.execute("""
                                    SELECT cmd.CmdNo_Commande, art.ArtArticle, art.ArtVariante, art.ArtQuantite,
                                    cmd.CmdPers_passe_Cmd, cmd.CmdStatus, cmd.CmdCommande_le,cmd.CmdRecu_le,
                                    cmd.CmdRemarque, fourn.FournNom_fournisseur, art.ArtNo_Article
                                    FROM tblcommande AS cmd
                                    INNER JOIN tblcmd_art AS ca
                                    ON cmd.Id_commande = ca.Fk_Cmd
                                    INNER JOIN tblarticle AS art
                                    ON ca.Fk_Art = art.Id_article
                                    INNER JOIN tblcmd_fourn AS cf
                                    ON cmd.Id_commande = cf.Fk_Cmd
                                    INNER JOIN tblfournisseur AS fourn
                                    ON cf.Fk_Fourn = fourn.Id_Fourn
                                    WHERE cmd.Id_commande = %s
                                    """, (id_commande,))
            modify_cmd = cursor.fetchall()

            # Créer le formulaire de modification avec les types de données appropriés et envoyer au JSON
            form_fields = []
            for i, row in enumerate(modify_cmd[0]):
                column_name, data_type = column_types[i]
                if data_type == 'int':
                    form_fields.append({'name': column_name, 'type': 'number', 'value': row})
                elif data_type == 'varchar':
                    form_fields.append({'name': column_name, 'type': 'text', 'value': row})
                elif data_type == 'date':
                    form_fields.append({'name': column_name, 'type': 'date', 'value': row.strftime('%Y-%m-%d')})
                else:
                    form_fields.append({'name': column_name, 'type': 'text', 'value': row})

            return jsonify({'data': form_fields, 'action': 'update'})
        except Exception as e:
            connection.rollback()
            return jsonify({'message': 'Une erreur est survenue !', 'error': str(e)})
        finally:
            connection.close()


# Route pour modifier les commandes
@app.route('/modifier_commandes', methods=['POST'])
def modifier_commandes():
    if request.method == 'POST':
        no_commandes = request.form['CmdNo_Commande']
        article = request.form['ArtArticle']
        variante = request.form['ArtVariante']
        quantite = request.form['ArtQuantite']
        commande_par = request.form['CmdPers_passe_Cmd']
        statut = request.form['CmdStatus']
        commande_le = request.form['CmdCommande_le']
        recu_le = request.form['CmdRecu_le']
        remarques = request.form['CmdRemarque']
        fournisseur = request.form['fournisseur_name']
        no_article = request.form['ArtNo_Article']
        id_commande = session.get('id_commande')
        id_fourn = session.get('id_fourn')
        id_article = session.get('id_article')

        # Connexion à la base de données
        connection = pymysql.connect(host=os.getenv("DB_HOST"),
                                     user=os.getenv("DB_USER_D"),
                                     password=os.getenv("DB_PASSWORD_D"),
                                     database=os.getenv("DB_NAME"))
        cursor = connection.cursor()
        try:
            # Récupérer l'ID du fournisseur séléctionner dans le formulaire
            cursor.execute("SELECT Id_Fourn FROM tblfournisseur WHERE FournNom_fournisseur = %s", fournisseur)
            row = cursor.fetchone()
            id_selected_fourn = row[0]

            # Requête pour faire un UPDATE sur la table tblcommande
            tblcommande_update = ("""
                                UPDATE tblcommande
                                SET CmdNo_Commande = %s, CmdPers_passe_Cmd = %s, CmdStatus = %s,
                                CmdCommande_le = %s, CmdRecu_le = %s, CmdRemarque = %s
                                WHERE Id_commande = %s;
                                """)
            cursor.execute(tblcommande_update, (no_commandes, commande_par, statut, commande_le, recu_le, remarques,
                                                id_commande))

            # Requête pour faire un UPDATE sur la table tblarticle
            tblarticle_update = ("""
                                UPDATE tblarticle
                                SET ArtArticle = %s, ArtVariante = %s, ArtQuantite = %s, ArtNo_Article = %s
                                WHERE Id_article = %s;
                                """)
            cursor.execute(tblarticle_update, (article, variante, quantite, no_article, id_article))

            # Requête pour faire un UPDATE du fournisseur qui est lié à la commande
            fournisseurs_update = ("""
                                    UPDATE tblcmd_fourn
                                    SET Fk_Fourn = %s
                                    WHERE Fk_Cmd = %s
                                    """)
            cursor.execute(fournisseurs_update, (id_selected_fourn, id_commande))

            connection.commit()
            return redirect(url_for('afficher_donnees'))
        except Exception as e:
            connection.rollback()
            return "Une erreur est survenue", e
        finally:
            cursor.close()


# Route pour traiter les actions des fournisseurs
@app.route('/handle_action_fourn', methods=['POST'])
def handle_action_fourn():
    data = request.get_json()
    content = data.get('content')
    email = data.get('email')
    action = data.get('action')

    try:
        # Si l'action est delete, supprimer le fournisseur
        if action == 'delete':
            with pymysql.connect(host=os.getenv("DB_HOST"),
                                 user=os.getenv("DB_USER_A"),
                                 password=os.getenv("DB_PASSWORD_A"),
                                 database=os.getenv("DB_NAME")) as connection:
                cursor = connection.cursor()

                # Vérifier si le fournisseur n'est pas lié à une commande
                cursor.execute("""
                                SELECT COUNT(*) FROM tblcmd_fourn AS CF
                                INNER JOIN tblfournisseur AS fourn
                                ON CF.Fk_Fourn = fourn.Id_Fourn
                                WHERE fourn.FournNom_fournisseur = %s;
                                """, (content,))
                use = cursor.fetchone()[0]
                if use != 0:
                    return jsonify({'message': '001'}), 200  # Erreur, car le fournisseur est lié à une commande

                # Désactiver temporairement les contraintes de clé étrangère
                cursor.execute("SET FOREIGN_KEY_CHECKS = 0")

                # Déplacer le fournisseur dans la table "poubelle"
                move = ("""
                            INSERT INTO tblsarlacc2 (SANom_fournisseur, SADoaine_vente, SATelephone, SAMail)
                            SELECT fourn.FournNom_fournisseur, fourn.Fourn_domaine_vente, cont.ContNo_telephone, cont.ContMail
                            FROM tblfournisseur AS fourn
                            JOIN tblfourn_cont AS FC ON fourn.Id_Fourn = FC.Fk_Fourn
                            JOIN tblcontact AS cont ON FC.Fk_Cont = cont.Id_contact
                            WHERE FournNom_fournisseur = %s AND cont.ContMail = %s;
                            """)
                cursor.execute(move, (content, email))

                # Supprimer les données une fois qu'elles ont été déplacé dans la table "poubelle"
                remove = ("""
                            DELETE fourn, FC, cont
                            FROM tblfournisseur AS fourn
                            JOIN tblfourn_cont AS FC ON fourn.Id_Fourn = FC.Fk_Fourn
                            JOIN tblcontact AS cont ON FC.Fk_Cont = cont.Id_contact
                            WHERE FournNom_fournisseur = %s AND cont.ContMail = %s;
                            """)
                cursor.execute(remove, (content, email))

                # Réactiver les contraintes de clé étrangère
                cursor.execute("SET FOREIGN_KEY_CHECKS = 1")

                connection.commit()
                return jsonify({'message': '000'}), 200  # Fournisseur supprimé avec succès !

        # Si l'action est update, modifier le fournisseur
        elif action == 'update':
            with pymysql.connect(host=os.getenv("DB_HOST"),
                                 user=os.getenv("DB_USER_B"),
                                 password=os.getenv("DB_PASSWORD_B"),
                                 database=os.getenv("DB_NAME")) as connection:
                cursor = connection.cursor()

                # Récupérer l'ID du fournisseur
                cursor.execute("""
                                SELECT Id_Fourn FROM tblfournisseur AS fourn
                                INNER JOIN tblfourn_cont AS FC ON fourn.Id_Fourn = FC.Fk_Fourn
                                INNER JOIN tblcontact AS cont ON FC.Fk_Cont = cont.Id_contact
                                WHERE fourn.FournNom_fournisseur = %s AND cont.ContMail = %s
                                 """, (content, email))
                id_fournisseur = cursor.fetchall()

                # Stocker id_fournisseur dans la session Flask
                session['id_fournisseur'] = id_fournisseur

                # Récupérer les types de données des colonnes
                cursor.execute("""
                    SELECT 
                        c.COLUMN_NAME,
                        c.DATA_TYPE
                    FROM
                        INFORMATION_SCHEMA.COLUMNS c
                    WHERE
                        c.TABLE_NAME IN ('tblfournisseur', 'tblfourn_cont', 'tblcontact')
                        AND c.COLUMN_NAME IN ('FournNom_fournisseur', 'Fourn_domaine_vente', 'ContNo_telephone', 'ContMail')
                        AND c.TABLE_SCHEMA = 'ruegg_thomas_expi1b_pappy_john'
                        ORDER BY FIELD(c.COLUMN_NAME, 'FournNom_fournisseur', 'Fourn_domaine_vente', 'ContNo_telephone', 'ContMail');
                        """)
                column_types = cursor.fetchall()

                # Requete SQl pour séléctionner les données pour la modification
                cursor.execute("""
                                SELECT DISTINCT fourn.FournNom_fournisseur, fourn.Fourn_domaine_vente, cont.ContNo_telephone,
                                cont.ContMail
                                FROM tblfournisseur AS fourn
                                INNER JOIN tblfourn_cont AS fc
                                ON fourn.Id_Fourn = fc.Fk_Fourn
                                INNER JOIN tblcontact AS cont
                                ON fc.Fk_Cont = cont.Id_contact
                                WHERE fourn.Id_Fourn = %s;
                                """, id_fournisseur)
                modify_fourn = cursor.fetchall()

                # Créer le formulaire de modification avec les types de données appropriés et envoyer au JSON
                form_fields = []
                for i, row in enumerate(modify_fourn[0]):
                    column_fourn_name, data_fourn_type = column_types[i]
                    if data_fourn_type == 'int':
                        form_fields.append({'name': column_fourn_name, 'type': 'number', 'value': row})
                    elif data_fourn_type == 'varchar':
                        form_fields.append({'name': column_fourn_name, 'type': 'text', 'value': row})
                    elif data_fourn_type == 'date':
                        form_fields.append({'name': column_fourn_name, 'type': 'date', 'value': row.strftime('%Y-%m-%d')})
                    else:
                        form_fields.append({'name': column_fourn_name, 'type': 'text', 'value': row})

                return jsonify({'action': 'update', 'form_fields': form_fields}), 200

        else:
            return jsonify({'message': 'Action inconnue'}), 400
    except Exception as e:
        return jsonify({'message': 'Une erreur est survenue lors du traitement de la requête'}), 500


# Route pour modifier les données sur les fournisseurs
@app.route('/modifier_fournisseur', methods=['POST'])
def modifier_fournisseur():
    if request.method == 'POST':
        nom_fournisseur = request.form['FournNom_fournisseur']
        domaine_vente = request.form['Fourn_domaine_vente']
        no_telephone = request.form['ContNo_telephone']
        email = request.form['ContMail']
        id_fournisseur = session.get('id_fournisseur')

        # Connexion à la base de données
        connection = pymysql.connect(host=os.getenv("DB_HOST"),
                                     user=os.getenv("DB_USER_D"),
                                     password=os.getenv("DB_PASSWORD_D"),
                                     database=os.getenv("DB_NAME"))
        cursor = connection.cursor()

        try:
            # Requête pour séléctionner l'ID qui est lié au fournisseur dans la table contact
            cursor.execute("""
                            SELECT cont.Id_contact
                            FROM tblcontact AS cont
                            INNER JOIN tblfourn_cont AS FC ON cont.Id_contact = FC.Fk_Cont
                            INNER JOIN tblfournisseur AS fourn ON FC.Fk_Fourn = fourn.Id_Fourn
                            WHERE fourn.Id_Fourn = %s
                            """, (id_fournisseur,))
            row = cursor.fetchone()
            id_contact = row[0]

            # Requête pour faire un update sur la table tblfournisseur
            tblfournisseur_update = ("""
                                    UPDATE tblfournisseur
                                    SET FournNom_fournisseur = %s, Fourn_domaine_vente = %s
                                    WHERE Id_Fourn = %s
                                    """)
            cursor.execute(tblfournisseur_update, (nom_fournisseur, domaine_vente, id_fournisseur))

            # Requête pour faire un update sur la table tblcontact
            tblcontact_update = ("""
                                UPDATE tblcontact
                                SET ContNo_telephone = %s, ContMail = %s
                                WHERE Id_contact = %s
                                """)
            cursor.execute(tblcontact_update, (no_telephone, email, id_contact))

            connection.commit()
            return redirect(url_for('afficher_donnees'))
        except Exception as e:
            connection.rollback()
            return f"Une erreur est survenue: {str(e)}"
        finally:
            connection.close()


# Router pour revenire en arrière après une suppresion de commande
@app.route('/back_cmd_remove', methods=['POST'])
def back_cmd_remove():
    if request.method == 'POST':
        # Connexion à la base de données
        connection = pymysql.connect(host=os.getenv("DB_HOST"),
                                     user=os.getenv("DB_USER_A"),
                                     password=os.getenv("DB_PASSWORD_A"),
                                     database=os.getenv("DB_NAME"))

        cursor = connection.cursor()

        active = request.json['active']

        # Si la variable active est égale à "YES" on fait revenir la commande
        if active == 'YES':

            # Récupérer le dernier ID de la table "poubelle" qui sera la commande récupérée
            cursor.execute("SELECT Max(Id_sarlacc) FROM tblsarlacc1;")
            last_id = cursor.fetchall()[0]

            try:
                # Déplacer la commande de la table "poubelle" dans la table tblcommande
                move_tblcommande = ("""
                                    INSERT INTO tblcommande (CmdNo_Commande, CmdPers_passe_Cmd, CmdStatus, CmdCommande_le,
                                                            CmdRecu_le, CmdRemarque)
                                    SELECT sa.SANo_commande, sa.SACommande_par, sa.SAStatut, sa.SACommande_le, sa.SARecu_le, sa.SARemarque
                                    FROM tblsarlacc1 AS sa
                                    WHERE sa.Id_sarlacc = %s;
                                    """)
                cursor.execute(move_tblcommande, (last_id,))
                commande_id = cursor.lastrowid  # Récupérer l'ID de la commande insérée

                # Déplacer la commande de la table "poubelle" dans la table tblarticle
                move_tblarticle = ("""
                                    INSERT INTO tblarticle (ArtArticle, ArtVariante, ArtQuantite, ArtNo_Article)
                                    SELECT sa.SAArticle, sa.SAVariante, sa.SAQuantite, sa.SANo_article
                                    FROM tblsarlacc1 AS sa
                                    WHERE sa.Id_sarlacc = %s;
                                    """)
                cursor.execute(move_tblarticle, (last_id,))
                article_id = cursor.lastrowid  # Récupérer l'ID de l'article inséré

                # Désactiver les contraintes de clés étrangères
                cursor.execute("SET FOREIGN_KEY_CHECKS = 0")

                # Déplacer la commande de la table "poubelle" dans la table tblcmdfourn
                move_tblcmdfourn = ("""
                                    INSERT INTO tblcmd_fourn (Fk_Cmd, Fk_Fourn)
                                    VALUES (%s, (
                                        SELECT sa.SALiaison_fournisseur
                                        FROM tblsarlacc1 AS sa
                                        WHERE sa.Id_sarlacc = %s
                                    ));     
                                    """)
                cursor.execute(move_tblcmdfourn, (commande_id, last_id))

                # Réactiver les contraintes de clés étrangères
                cursor.execute("SET FOREIGN_KEY_CHECKS = 1")

                # Créer les FK dans la table tblcmd_art pour lier la commande avec l'article
                move_tblcmdart = ("""
                                    INSERT INTO tblcmd_art (Fk_Cmd, Fk_Art)
                                    VALUES(%s, %s)
                                    """)
                cursor.execute(move_tblcmdart, (commande_id, article_id))

                # Supprimer la commande restaurée de la table "poubelle"
                remove = ("""
                            DELETE SA
                            FROM tblsarlacc1 AS SA
                            WHERE Id_sarlacc = %s
                            """)
                cursor.execute(remove, (last_id,))

                connection.commit()
                return jsonify({'message': 'Commande restaure avec succes !'})
            except Exception as e:
                connection.rollback()
                return jsonify({'message': str(e)})
            finally:
                connection.close()


# Route pour faire revenir un fournisseur supprimé
@app.route('/back_fourn_remove', methods=['POST'])
def back_fourn_remove():
    if request.method == 'POST':
        # Connexion à la base de données
        connection = pymysql.connect(host=os.getenv("DB_HOST"),
                                     user=os.getenv("DB_USER_A"),
                                     password=os.getenv("DB_PASSWORD_A"),
                                     database=os.getenv("DB_NAME"))

        cursor = connection.cursor()

        active = request.json['active']

        # Si la variable active est égale à "YES" on fait revenir le fournisseur
        if active == 'YES':
            try:
                # Récupérer le dernier ID de la table "poubelle" qui sera le fournisseur récupérée
                cursor.execute("SELECT Max(Id_sarlacc) FROM tblsarlacc2;")
                last_id = cursor.fetchall()[0]

                # Déplacer le fournissuer de la table "poubelle" dans la table tblfournisseur
                move_tblfournisseur = ("""
                                        INSERT INTO tblfournisseur (FournNom_fournisseur, Fourn_domaine_vente)
                                        SELECT SANom_fournisseur, SADoaine_vente
                                        FROM tblsarlacc2
                                        WHERE Id_sarlacc = %s
                                        """)
                cursor.execute(move_tblfournisseur, (last_id,))
                fournisseur_id = cursor.lastrowid  # Récupérer l'ID du fournisseur inséré

                # Déplacer le fournissuer de la table "poubelle" dans la table tblcontact
                move_tblcontact = ("""
                                    INSERT INTO tblcontact (ContNo_telephone, ContMail)
                                    SELECT SATelephone, SAMail
                                    FROM tblsarlacc2
                                    WHERE Id_sarlacc = %s
                                    """)
                cursor.execute(move_tblcontact, (last_id,))
                contact_id = cursor.lastrowid  # Récupérer l'ID du contact inséré

                # Créer les FK dans la table tblfourn_cont pour lier le fournisseur avec un contact
                move_tblfourn_cont = ("""
                                        INSERT INTO tblfourn_cont (Fk_Fourn, Fk_Cont)
                                        VALUES(%s, %s)
                                        """)
                cursor.execute(move_tblfourn_cont, (fournisseur_id, contact_id))

                # Supprimer le fournisseur restauré de la table "poubelle"
                remove = ("""
                            DELETE SA
                            FROM tblsarlacc2 AS SA
                            WHERE Id_sarlacc = %s
                            """)
                cursor.execute(remove, (last_id,))

                connection.commit()
                return jsonify({'message': '000'})  # Code pour indiquer que le fournisseur à été restauré
            except Exception as e:
                connection.rollback()
                return jsonify({'message': str(e)})
            finally:
                connection.close()


if __name__ == '__main__':
    app.run(debug=True, port=8000)
