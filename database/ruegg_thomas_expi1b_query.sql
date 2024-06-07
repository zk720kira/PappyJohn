/*Les requête si dessous on été adaptée car dans l'application Flask des variables sont utilisé dans les query SQL. Ces variable sont soit récupérées d'un formulaire HTML soit d'un JSON.*/
/*Les variables ont donc été enlevée et changée par des données qui sont contenues dans la base de données pour que les query puissent être executée pour prouver leur bon fonctionnement.*/


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

SELECT DISTINCT FournNom_fournisseur FROM tblfournisseur;

SELECT DISTINCT fourn.FournNom_fournisseur, fourn.Fourn_domaine_vente, cont.ContNo_telephone,
cont.ContMail
FROM tblfournisseur AS fourn
INNER JOIN tblfourn_cont AS fc
ON fourn.Id_Fourn = fc.Fk_Fourn
INNER JOIN tblcontact AS cont
ON fc.Fk_Cont = cont.Id_contact;

INSERT INTO tblarticle(ArtArticle, ArtVariante, ArtQuantite,
						ArtNo_Article) VALUES ('test', '1kg', 100, '13ab9');  /*Ces données sont uniquement insérées pour de la démonstration !*/

INSERT INTO tblcommande(CmdNo_Commande, CmdPers_passe_Cmd, CmdStatus, CmdCommande_le,
                            CmdRecu_le, CmdRemarque) VALUES (150, 'Testeur', 'En cours de test', '2000-12-31', '2001-12-31', 'Trop de retard ! Demander un rembourssement !');  /*Ces données sont uniquement insérées pour de la démonstration !*/

SELECT Id_Fourn FROM tblfournisseur WHERE FournNom_fournisseur = 'Module 164';  /* Les données seléctionnées sont pour de la démonstration, il est possible quu la séléction ne fonctionne pas si les données ont été modifié. Si c'est le cas il faut à nouveau exécuter le dump.sql.*/

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO tblcmd_fourn(Fk_Cmd, Fk_Fourn) VALUES (143, 50);  /*Ces données sont uniquement insérée pour de la démonstration !*/

INSERT INTO tblcmd_art(Fk_Cmd, Fk_Art) VALUES (143, 161);  /*Ces données sont uniquement insérées pour de la démonstration !*/

INSERT INTO tblfournisseur(FournNom_fournisseur, Fourn_domaine_vente) VALUES ('test164', 'Ne vend rien !');  /*Ces données sont uniquement insérées pour de la démonstration !*/

INSERT INTO tblcontact(ContNo_telephone, ContMail) VALUES ('+41 78 983 25 89', 'test164@gmail.com');  /*Ces données sont uniquement insérées pour de la démonstration !*/

INSERT INTO tblfourn_cont(Fk_Fourn, Fk_cont) VALUES (40, 40);  /*Ces données sont uniquement insérées pour de la démonstration !*/

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
WHERE cmd.Id_commande = 184;  /*Ces données sont uniquement insérées pour de la démonstration ! Les données qui seront insérée dans cette table (qui est la table poubelle) seront ensuite surpprimée de la table des commandes*/

DELETE CF, CA, cmd, art
FROM tblcmd_fourn AS CF
JOIN tblcommande AS cmd ON CF.Fk_Cmd = cmd.Id_commande
JOIN tblcmd_art AS CA ON cmd.Id_commande = CA.Fk_Cmd
JOIN tblarticle AS art ON CA.Fk_Art = art.Id_article
WHERE cmd.Id_commande = 184;

SET FOREIGN_KEY_CHECKS = 1;

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
WHERE cmd.Id_commande = 143;  /* Les données seléctionnées sont pour de la démonstration, il est possible quu la séléction ne fonctionne pas si les données ont été modifié. Si c'est le cas il faut à nouveau exécuter le dump.sql.*/

SELECT Id_Fourn FROM tblfournisseur WHERE FournNom_fournisseur = 'Test2';  /* Les données seléctionnées sont pour de la démonstration, il est possible quu la séléction ne fonctionne pas si les données ont été modifié. Si c'est le cas il faut à nouveau exécuter le dump.sql.*/

UPDATE tblcommande
SET CmdNo_Commande = 10, CmdPers_passe_Cmd = 'Patron', CmdStatus = 'Arrivé',
CmdCommande_le = '2024-04-24', CmdRecu_le = '2024-05-03', CmdRemarque = 'Bien arrivé !'
WHERE Id_commande = 182;  /*Les données sont uniquement mises à jours pour de la démonstration*/

UPDATE tblarticle
SET ArtArticle = 'TestART', ArtVariante = '10kg', ArtQuantite = 100, ArtNo_Article = '12bfa'
WHERE Id_article = 191;  /*Les données sont uniquement mises à jours pour de la démonstration*/

UPDATE tblcmd_fourn
SET Fk_Fourn = 50
WHERE Fk_Cmd = 182;  /*Les données sont uniquement mises à jours pour de la démonstration*/

SELECT COUNT(*) FROM tblcmd_fourn AS CF
INNER JOIN tblfournisseur AS fourn
ON CF.Fk_Fourn = fourn.Id_Fourn
WHERE fourn.FournNom_fournisseur = 50;  /* Les données seléctionnées sont pour de la démonstration, il est possible quu la séléction ne fonctionne pas si les données ont été modifié. Si c'est le cas il faut à nouveau exécuter le dump.sql.*/

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO tblsarlacc2 (SANom_fournisseur, SADomaine_vente, SATelephone, SAMail)
SELECT fourn.FournNom_fournisseur, fourn.Fourn_domaine_vente, cont.ContNo_telephone, cont.ContMail
FROM tblfournisseur AS fourn
JOIN tblfourn_cont AS FC ON fourn.Id_Fourn = FC.Fk_Fourn
JOIN tblcontact AS cont ON FC.Fk_Cont = cont.Id_contact
WHERE fourn.Id_Fourn = 50 AND cont.Id_contact = 50;  /*Ces données sont uniquement insérées pour de la démonstration ! Les données qui seront insérée dans cette table (qui est la table poubelle) seront ensuite surpprimée de la table des commandes*/

DELETE fourn, FC, cont
FROM tblfournisseur AS fourn
JOIN tblfourn_cont AS FC ON fourn.Id_Fourn = FC.Fk_Fourn
JOIN tblcontact AS cont ON FC.Fk_Cont = cont.Id_contact
WHERE fourn.Id_Fourn = 50 AND cont.Id_contact = 50;

SET FOREIGN_KEY_CHECKS = 1;

SELECT Id_Fourn FROM tblfournisseur AS fourn
INNER JOIN tblfourn_cont AS FC ON fourn.Id_Fourn = FC.Fk_Fourn
INNER JOIN tblcontact AS cont ON FC.Fk_Cont = cont.Id_contact
WHERE fourn.Id_Fourn = 54 AND cont.Id_contact = 54;  /* Les données seléctionnées sont pour de la démonstration, il est possible quu la séléction ne fonctionne pas si les données ont été modifié. Si c'est le cas il faut à nouveau exécuter le dump.sql.*/
 
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

SELECT DISTINCT fourn.FournNom_fournisseur, fourn.Fourn_domaine_vente, cont.ContNo_telephone,
cont.ContMail
FROM tblfournisseur AS fourn
INNER JOIN tblfourn_cont AS fc
ON fourn.Id_Fourn = fc.Fk_Fourn
INNER JOIN tblcontact AS cont
ON fc.Fk_Cont = cont.Id_contact
WHERE fourn.Id_Fourn = 51;  /* Les données seléctionnées sont pour de la démonstration, il est possible quu la séléction ne fonctionne pas si les données ont été modifié. Si c'est le cas il faut à nouveau exécuter le dump.sql.*/

SELECT cont.Id_contact
FROM tblcontact AS cont
INNER JOIN tblfourn_cont AS FC ON cont.Id_contact = FC.Fk_Cont
INNER JOIN tblfournisseur AS fourn ON FC.Fk_Fourn = fourn.Id_Fourn
WHERE fourn.Id_Fourn = 51;  /* Les données seléctionnées sont pour de la démonstration, il est possible quu la séléction ne fonctionne pas si les données ont été modifié. Si c'est le cas il faut à nouveau exécuter le dump.sql.*/

UPDATE tblfournisseur
SET FournNom_fournisseur = 'info164', Fourn_domaine_vente = 'Ne vend rien !'
WHERE Id_Fourn = 51;  /*Les données sont uniquement mises à jours pour de la démonstration*/

UPDATE tblcontact
SET ContNo_telephone = '+41 78 111 11 11', ContMail = 'info164@gmail.com'
WHERE Id_contact = 51;  /*Les données sont uniquement mises à jours pour de la démonstration*/

SELECT Max(Id_sarlacc) FROM tblsarlacc1;

INSERT INTO tblcommande (CmdNo_Commande, CmdPers_passe_Cmd, CmdStatus, CmdCommande_le,
						CmdRecu_le, CmdRemarque)
SELECT sa.SANo_commande, sa.SACommande_par, sa.SAStatut, sa.SACommande_le, sa.SARecu_le, sa.SARemarque
FROM tblsarlacc1 AS sa
WHERE sa.Id_sarlacc = 96;  /* Les données seléctionnées sont pour de la démonstration, il est possible quu la séléction ne fonctionne pas si les données ont été modifié. Si c'est le cas il faut à nouveau exécuter le dump.sql.*/

INSERT INTO tblarticle (ArtArticle, ArtVariante, ArtQuantite, ArtNo_Article)
SELECT sa.SAArticle, sa.SAVariante, sa.SAQuantite, sa.SANo_article
FROM tblsarlacc1 AS sa
WHERE sa.Id_sarlacc = 96;  /*Ces données sont uniquement insérée pour de la démonstration !*/

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO tblcmd_fourn (Fk_Cmd, Fk_Fourn)
VALUES (396, (
	SELECT sa.SALiaison_fournisseur
	FROM tblsarlacc1 AS sa
	WHERE sa.Id_sarlacc = 96
));  /*Ces données sont uniquement insérée pour de la démonstration !*/

INSERT INTO tblcmd_art (Fk_Cmd, Fk_Art)
VALUES(396, 498);  /*Ces données sont uniquement insérée pour de la démonstration !*/

DELETE SA
FROM tblsarlacc1 AS SA
WHERE Id_sarlacc = 96;

SELECT Max(Id_sarlacc) FROM tblsarlacc2;

INSERT INTO tblfournisseur (FournNom_fournisseur, Fourn_domaine_vente)
SELECT SANom_fournisseur, SADomaine_vente
FROM tblsarlacc2
WHERE Id_sarlacc = 30;  /*Ces données sont uniquement insérée pour de la démonstration !*/

INSERT INTO tblcontact (ContNo_telephone, ContMail)
SELECT SATelephone, SAMail
FROM tblsarlacc2
WHERE Id_sarlacc = 30;  /*Ces données sont uniquement insérée pour de la démonstration !*/

INSERT INTO tblfourn_cont (Fk_Fourn, Fk_Cont)
VALUES(890, 890);  /*Ces données sont uniquement insérée pour de la démonstration !*/

DELETE SA
FROM tblsarlacc2 AS SA
WHERE Id_sarlacc = 30;

SET FOREIGN_KEY_CHECKS = 1;

/*En cas d'erreur il faut à nouveau importer le dump.sql*/