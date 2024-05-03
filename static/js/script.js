// Thomas Rüegg
// Si on recharge la page web depuis la vue des données sur les fournisseurs, retourner directement dessus
if(localStorage.getItem("afficher fournisseur") === "True") {
    showFourn()
}

// Fonction pour remplacer les cellules contenant "None" ou rien par "Pas de données dans le tableau des commandes
function replaceEmptyCellulesCommandes() {
    let table = document.querySelector('table'); // Sélectionner le tableau

    // Parcourir chaque ligne du tableau
    table.querySelectorAll('tr').forEach(function(row) {
        // Parcourir chaque cellule de la ligne
        row.querySelectorAll('td').forEach(function(cell) {
            // Vérifier si la valeur de la cellule est "None", rien ou la date 01.01.0001 et la remplacer par "Pas de données"
            if (cell.innerHTML.trim() === 'None' || cell.innerHTML.trim() === "" || cell.innerHTML.trim() === "01.01.0001") {
                cell.innerHTML = 'Pas de donnée'; // Remplacer la cellule par "Pas de données"
            }
        });
    });
}

// Fonction pour remplacer les cellules contenant "None" ou rien par "Pas de données dans le tableau des fournisseurs
function replaceEmptyCellulesFourn() {
    let table = document.getElementById('tbl_fourn'); // Sélectionner le tableau

    // Parcourir chaque ligne du tableau
    table.querySelectorAll('tr.tr_fourn').forEach(function(row) {
        // Parcourir chaque cellule de la ligne
        row.querySelectorAll('td').forEach(function(cell) {
            // Vérifier si la valeur de la cellule est "None" ou rien et la remplacer par "Pas de données"
            if (cell.innerHTML.trim() === 'None' || cell.innerHTML.trim() === "") {
                cell.innerHTML = 'Pas de donnée'; // Remplacer la cellule par "Pas de données"
            }
        });
    });
}

// Appeler des fonctions lors du chargement de la page
window.onload = function() {
    replaceEmptyCellulesCommandes(); // Appeler la fonction pour remplacer les cellules contenant "None" par "Pas de données"
    replaceEmptyCellulesFourn(); // Appler la fonction pour remplacer les cellules contenant "None" par "Pas de données"
    checkStripedTable();
};

// Ouvrir la fenêtre avec le formulaire pour les nouvelles commandes
function openModal() {
    document.getElementById("myModal").style.display = "block";
}

// Fermer la fenêtre avec le formulaire pour les nouvelles commandes
function closeModal() {
    document.getElementById("myModal").style.display = "none";
}

// Ouvrir la fenêtre avec le formulaire pour ajouter des fournisseurs
function openModal2() {
    document.getElementById("myModal2").style.display = "block";
    localStorage.setItem("afficher fournisseur", "True");
}

// Fermer la fenêtre avec le formulaire pour ajouter des fournisseurs
function closeModal2() {
    document.getElementById("myModal2").style.display = "none";
}

// Contrôler que les inputs aient des valeurs, s'ils n'en n'ont pas ajouté un vide
let inputs_text = document.querySelectorAll('input [type="text"]');

// Parcourir chaque input
inputs_text.forEach(input => {
    // Vérifier si l'input est vide
    if (input.value === "") {
        input.value = " ";
    }
});

// Contrôler l'input de type date "recu_le"
let recu_le = document.getElementById("recu_le")
function controlDate() {
    if (recu_le.value === "") {
        recu_le.value = "0001-01-01";
    }
}

// Ouvrir la fenêtre avec le formulaire pour modifier les commandes
function openModal5() {
    document.getElementById("myModal5").style.display = "block";

    // Attendre que la fenêtre modale soit complètement affichée avant de récupérer l'input
    setTimeout(() => {
        // Récupérer l'input avec le nom "CmdRecu_le"
        let cmdRecuInput = document.querySelector('input[name="CmdRecu_le"]');

        // Vérifier si l'input a été trouvé
        if (cmdRecuInput) {
            // Vérifier si la valeur de l'input est égale à "01.01.0001"
            if(cmdRecuInput.value === '0001-01-01'){
                cmdRecuInput.value = "";
            }
        } else {
            // console.error('Impossible de trouver l\'input avec le nom "CmdRecu_le"'); // --> Pour du débug
        }
    }, 100); // Attendre 100 millisecondes avant de récupérer l'input

    // Changer le fournisseur qui apparait par dans la liste déroulant sur le popup pour modifer les commandes
    document.getElementById("fournisseur_name").value = localStorage.getItem("fournisseur")
}

// Fermer la fenêtre avec le formulaire pour modifier les commandes sans envoyer les données
function  closeModal5() {
    document.getElementById("myModal5").style.display = "none";
}

// Fermer la fenêtre avec le formulaire pour modifier les commandes et envoyer les données
function closeModal5SendData() {
    // Sélectionner les inputs qui sont obligatoires pour effectuer un contrôle
    let no_commande = document.querySelector('input[name="CmdNo_Commande"]');
    let article = document.querySelector('input[name="ArtArticle"]');
    let quantite = document.querySelector('input[name="ArtQuantite"]');
    let pers_commande = document.querySelector('input[name="CmdPers_passe_Cmd"]');
    let status = document.querySelector('input[name="CmdStatus"]');
    let commande_le = document.querySelector('input[name="CmdCommande_le"]');

    // Vérifier si tous les champs obligatoires sont remplis
    let allFieldsFilled = no_commande.value.trim() &&
                         article.value.trim() &&
                         quantite.value.trim() &&
                         pers_commande.value.trim() &&
                         status.value.trim() &&
                         commande_le.value.trim();

    if (allFieldsFilled) {
        // Tous les champs obligatoires sont remplis, fermer la fenêtre modale
        document.getElementById("myModal5").style.display = "none";

        // Contrôler le contenu de l'input avec la date de réception, s'il est vide ajouter 0001-01-01
        let cmdRecuInput = document.querySelector('input[name="CmdRecu_le"]');
        if (cmdRecuInput.value === '') {
            cmdRecuInput.value = "0001-01-01";
        }

        // Envoyer le formulaire
        document.querySelector('form[action="/modifier_commandes"]').submit();
    } else {
        // Un ou plusieurs champs obligatoires sont vides, afficher une alerte
        alert("Veuillez remplir tous les champs obligatoires.");
    }
}


// Ouvrir la fenêtre avec le formulaire pour modifier des fournisseurs
function openModal6() {
    document.getElementById("myModal6").style.display = "block";
}

// Femrer la fenêtre avec le formulaire pour modifier les fournisseurs sans envoyer les données
function closeModal6() {
    document.getElementById("myModal6").style.display = "none";
}

// Fermer la fenêtre avec le formulaire pour modifier les fournisseurs et envoyer les données
function closeModal6SendData() {
    // Séléctionner les inputs qui sont obligatoir pour effectuer un contrôle
    let nom_fournisseur = document.querySelector('input[name="FournNom_fournisseur"]')
    let email = document.querySelector('input[name="ContMail"]')

    // Vérifier si tous les champs obligatoir sont remplis
        let allFieldsFilled = nom_fournisseur.value.trim() &&
                         email.value.trim();

    if (allFieldsFilled) {
        // Tous les champs obligatoires sont remplis, fermer la fenêtre modale
        document.getElementById("myModal6").style.display = "none";

        // Envoyer le formulaire
        document.querySelector('form[action="/modifier_fournisseur"]').submit();
    } else {
        // Un ou plusieurs champs obligatoires sont vides, afficher une alerte
        alert("Veuillez remplir tous les champs obligatoires.");
    }
}

// Fonction pour ouvrir la fenêtre avec les paramètres
function openModalSettings() {
    document.getElementById("modal_settings").style.display = "block";
}

// Fonction pour fermer la fenêtre avec les paramètres
function closeModalSettings() {
    document.getElementById("modal_settings").style.display = "none";
}

// Autorisation des notifications
/*Notification.requestPermission().then(function(permission) {
    if (permission === 'granted') {
        console.log('Permission for notifications granted');
    }
});*/


// Récupérer le numéro de la commande pour la sélectionner et ensuite fair un UPDATE
function getUpdateID(event) {
    event.preventDefault();
    let id = event.target.closest('tr').querySelector('td:nth-child(2)').innerText;
    let id_fourn = event.target.closest('tr').querySelector('td:nth-child(3)').innerHTML;
    let id_article = event.target.closest('tr').querySelector('td:nth-child(4)').innerHTML;
    let content = event.target.closest('tr').querySelector('td:first-child').innerText;
    let article = event.target.closest('tr').querySelector('td:nth-child(5)').innerText;
    let quantity = event.target.closest('tr').querySelector('td:nth-child(7)').innerText;
    let command_by = event.target.closest('tr').querySelector('td:nth-child(8)').innerText;
    let fourn = event.target.closest('tr').querySelector('td:nth-child(13)').innerText;
    localStorage.setItem('fournisseur', fourn)
    // console.log(id, id_fourn, id_article, content, article, quantity, command_by, fourn) // --> Pour du débug
    sendDataToFlask(id, id_fourn, id_article, content, article, quantity, command_by, 'update');
}

// Récupérer le numéro de commande pour la sélectionner et ensuite la supprimer
function getDeleteID(event) {
    event.preventDefault();
    let id = event.target.closest('tr').querySelector('td:nth-child(2)').innerText;
    let id_fourn = event.target.closest('tr').querySelector('td:nth-child(3)').innerHTML;
    let id_article = event.target.closest('tr').querySelector('td:nth-child(4)').innerHTML;
    let content = event.target.closest('tr').querySelector('td:first-child').innerText;
    let article = event.target.closest('tr').querySelector('td:nth-child(5)').innerText;
    let quantity = event.target.closest('tr').querySelector('td:nth-child(7)').innerText;
    let command_by = event.target.closest('tr').querySelector('td:nth-child(8)').innerText;
    let fourn = event.target.closest('tr').querySelector('td:nth-child(13)').innerText;
    // console.log(id, id_fourn, id_article, content, article, quantity, command_by, 'delete') // --> Pour du débug
    // Demander à l'utilisateur s'il veut vraiment supprimer la commande
    if(confirm("La commande sélectionée sera supprimée, voulez-vous vraiment continuer ?") === true) {
        sendDataToFlask(id, id_fourn, id_article, content, article, quantity, command_by, 'delete');
    }
    else {
        // console.log("La suppression de la commande No." + content + " à été annulée !"); // --> Pour du débug
    }
}

// Envoyer la requête au Flask et gérer le retour du Flask pour les commandes
function sendDataToFlask(id, id_fourn, id_article, content, article, quantity, command_by, action) {
    fetch('/handle_action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({id: id, id_fourn: id_fourn, id_article: id_article, content: content, article: article, quantity: quantity, command_by: command_by, action: action})
    })
    .then(response => {
        if (response.ok) {
            // console.log(response) // --> Pour du débug
            return response.json();
        }
        throw new Error('Réponse non valide');
    })
    .then(data => {
        // console.log(data) // --> Pour du débug
        // Contrôler le retour du Flask et envoyer le résultat
        if(data.message === 'Commande supprimé avec succès !') {
            // console.log("Retours de Flask : " + data.message); // --> Pour du débug
            // Rafraichir la page pour rafraichir le tableau avec les données
            window.location.reload()
        } else if (data.action === 'update') {
            // console.log("Retours de Flask : " + data.message); // --> Pour du débug
            // Remplir le formulaire de modification avec les données récupérées
            let updateDiv = document.getElementById('update_div');
            updateDiv.innerHTML = '';
            for (let i = 0; i < data.data.length; i++) {
                let field = data.data[i];

                // Créer un paragraphe pour indiquer la donnée attendue
                let label = document.createElement('p');
                if (i === 0) {
                    label.textContent = "No. Commande * :";
                } else if (i === 1) {
                    label.textContent = "Article * :";
                } else if (i === 2) {
                    label.textContent = "Variante :"
                } else if (i === 3) {
                    label.textContent = "Quantité * :"
                } else if (i === 4) {
                    label.textContent = "Commandé par * :"
                } else if (i === 5) {
                    label.textContent = "Statut * :"
                } else if (i === 6) {
                    label.textContent = "Commandé le * :"
                } else if (i === 7) {
                    label.textContent = "Reçu le :"
                } else if (i === 8) {
                    label.textContent = "Remarques :"
                } else if (i === 9) {
                    label.textContent = "No. Article"
                }
                updateDiv.appendChild(label);

                // Créer l'input, si l'input a le nom FournNom_fournissuer, ne rien faire
                if (field.name !== 'FournNom_fournisseur') {
                    let input = document.createElement('input');
                    input.type = field.type;
                    input.name = field.name;
                    input.value = field.value || 'Pas de donnée';
                    updateDiv.appendChild(input);
                }
            }

            // Ajouter le nombre maximum de caractères aux inputs
            document.querySelector('input[name="CmdRemarque"]').maxLength = "100";
        } else {
            // console.log("Retours de Flask : " + data.message); // --> Pour du débug
        }
    })
    .catch(error => {
        // console.error('Une erreur s\'est produite:', error); // --> Pour du débug
    });
}

// Récupérer le nom du fournisseur pour le sélectionner et ensuite fair un UPDATE
function getUpdateFourn(event) {
    event.preventDefault();
    let content = event.target.closest('tr').querySelector('td:first-child').innerText;
    let email =  event.target.closest('tr').querySelector('td:nth-child(4)').innerText;
    // console.log(content, email, 'update') // --> Pour du débug
    sendDataToFlaskFourn(content, email, 'update')
}

// Récupérer le nom du fournisseur pour le sélectionner et ensuite fair un DELETE
function getDeleteFourn(event) {
    event.preventDefault();
    let content = event.target.closest('tr').querySelector('td:first-child').innerText;
    let email =  event.target.closest('tr').querySelector('td:nth-child(4)').innerText;
    // console.log(content, email) // --> Pour du débug
    // Demander à l'utilisateur s'il veut vraiment supprimer le fournisseur
    if(confirm("Le fournisseur : '" + content + "' sera supprimé, voulez-vous vraiment continuer ?") === true) {
        sendDataToFlaskFourn(content, email, 'delete')
    } else {
        // console.log("La suppression du fournisseur : '" + content + "' à été annulée !") // --> Pour du débug
    }
}

// Envoyer la requête au Flask et gérer le retour du Flask pour les fournisseurs
function sendDataToFlaskFourn(content, email, action) {
    fetch('/handle_action_fourn', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({content: content, email: email, action: action})
    })
    .then(response => {
        if (response.ok) {
            return response.json();
        } else {
            throw new Error('Réponse non valide');
        }
    })
    .then(data => {
        // console.log(data); // --> Pour du débug
        // Contrôler le retour du Flask pour envoyer les bonnes notifications
        if(data.message === '000'){
            // console.log("Retours de Flask : " + data.message); // --> Pour du débug
            // Recharger la page pour mettre à jour le tableau avec les fournisseurs
            window.location.reload();
        } else if(data.message === '001') {
            alert('Impossible de supprimer le fournisseur car il est utilisé dans une commande !');
        } else if(data.action === 'update'){
            // console.log("Retours de Flask : " + data.message); // --> Pour du débug
            // Remplir le formulaire de modification avec les données récupérées
            let updateDiv = document.getElementById('update_fourn_div');
            updateDiv.innerHTML = '';
            data.form_fields.forEach(field => {
                // Créer un paragraphe pour indiquer la donnée attendue
                let label = document.createElement('p');
                if (field.name === 'FournNom_fournisseur') {
                    label.textContent = "Nom du fournisseur * :";
                } else if (field.name === 'Fourn_domaine_vente') {
                    label.textContent = "Domaine de vente :";
                } else if (field.name === 'ContNo_telephone') {
                    label.textContent = "Numéro de téléphone :";
                } else if (field.name === 'ContMail') {
                    label.textContent = "Email * :";
                }
                updateDiv.appendChild(label);

                // Créer l'input
                let input = document.createElement('input');
                input.type = field.type;
                input.name = field.name;
                input.value = field.value || 'Pas de donnée';
                updateDiv.appendChild(input);

            });
        } else {
            // console.log(data.message); // --> Pour du débug
        }
    })
    .catch(error => {
        // console.error('Une erreur s\'est produite:', error); // --> Pour du débug
    });
}

// Fonction pour afficher le tableau des commandes et changer la couleur du bouton dans le menu
function showCmd() {
    document.getElementById("div_tbl_fourn").style.display = 'none';
    document.getElementById("div_tbl_cmd").style.display = 'inline';
    localStorage.setItem("afficher fournisseur", "False");
    document.getElementById("cmd_active").style.backgroundColor = '#F71F0A';
    document.getElementById("fourn_active").style.backgroundColor = '#111';
    // Afficher les boutons pour effectuer les actions sur le tableau des commandes
    document.getElementById("new_cmd").style.display = 'block';
    document.getElementById("back_cmd").style.display = 'block';
    // Enlever les boutons pour effectuer les actions sur le tableau des fournisseurs
    document.getElementById("new_fourn").style.display = 'none';
    document.getElementById("back_fourn").style.display = 'none';
    // Changer le texte dans l'input pour effectuer les recherches
    document.getElementById("searche").placeholder = "Filtrer une commande";
}

// Fonction pour afficher le tableau des fournisseurs et changer la couleur du bouton dans le menu
function showFourn() {
    document.getElementById("div_tbl_cmd").style.display = 'none';
    document.getElementById("div_tbl_fourn").style.display = 'inline';
    localStorage.setItem("afficher fournisseur", "True");
    document.getElementById("cmd_active").style.backgroundColor = '#111';
    document.getElementById("fourn_active").style.backgroundColor = '#F71F0A';
    // Afficher les boutons pour effectuer les actions sur le tableau des fournisseurs
    document.getElementById("new_fourn").style.display = 'block';
    document.getElementById("back_fourn").style.display = 'block';
    // Enlever les boutons pour effectuer les actions sur le tableau des commandes
    document.getElementById("new_cmd").style.display = 'none';
    document.getElementById("back_cmd").style.display = 'none';
    // Changer le texte dans l'input pour effectuer les recherches
    document.getElementById("searche").placeholder = "Filtrer un fournisseur";
}

// Fonction pour activer la route "/back_cmd_remove"
function sendToFlaskBackCMD() {
    fetch('/back_cmd_remove', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({active: 'YES'})
    })
    .then(response => {
        if (response.ok) {
            // console.log(response); // --> Pour du débug
            return response.json();
        }
        throw new Error('Réponse non valide');
    })
    .then(data => {
        // Afficher le retour de Flask
        // console.log(data.message) // --> Pour du débug

        // Si le retour de flask indinque que la table tblsarlacc1 est vide afficher un message
        if (data.message === 'Commande restaure avec succes !') {
            // Recharger la page pour mettre à jour la table des commandes
            location.reload()
        } else {
            alert("Plus aucune commande ne peux être restaurée !");
        }
    })
    .catch(error => {
        // console.error('Une erreur s\'est produite:', error); // --> Pour du débug
    });
}

// Fonction pour activer la route /back_fourn_remove
function sendToFlaskBackFRN() {
        fetch('/back_fourn_remove', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({active: 'YES'})
    })
    .then(response => {
        if (response.ok) {
            // console.log(response); // --> Pour du débug
            return response.json();
        }
        throw new Error('Réponse non valide');
    })
    .then(data => {
        // Recharger la page pour mettre à jour la table des commandes

        // Afficher le retour de Flask
        // console.log(data.message) // --> Pour du débug

        // Si le retour de flask indinque que la table tblsarlacc2 est vide afficher un message
        if (data.message === '000') {
            location.reload()
        } else {
            alert("Plus aucun fournissuer ne peux être restauré !");
        }
    })
    .catch(error => {
        // console.error('Une erreur s\'est produite:', error); // --> Pour du débug
    });
}

// Fonction activer/désactiver le style striped/"zèbré"
function StripedTable() {
    let striped = localStorage.getItem("striped"); // Variable qui contient la valeur de striped

    // Récupérer la variable dans le local storage pour savoir quelle action effectuer
    if(striped === "True") { // Si la table est "zèbrée" on enlève ce style
        // Tableau avec un tr séléctionné sur 2
        let tr_list = document.querySelectorAll('tr:nth-child(even)');

        // Parcourir chaques éléments
        tr_list.forEach(row => {
        // Appliquer le styla à chaques éléments
            row.style.backgroundColor = "white";
        });

        // Enregistrer dans le local storage que la table n'est pas "zèbrée"
        localStorage.setItem("striped", "False");

        // Changer la couleur du bouton et le texte
        document.getElementById("btn_modal_settings").textContent = "Activer";
        document.getElementById("btn_modal_settings").style.color = "green";
    }
    else if(striped === "False") { // Si la table n'est pas "zèbrée" on active ce style
        // Tableau avec un tr séléctionné sur 2
        let tr_list = document.querySelectorAll('tr:nth-child(even)');

        // Parcourir chaques éléments dans le tableau
        tr_list.forEach(row => {
            // Appliquer le styla à chaques éléments
            row.style.backgroundColor = "#f2f2f2"
        });

        // Enregistrer dans le local storage que la table est "zèbrée"
        localStorage.setItem("striped", "True");

        // Changer la couleur du bouton et le texte
        document.getElementById("btn_modal_settings").textContent = "Désactiver";
        document.getElementById("btn_modal_settings").style.color = "red";
    }
}

// Fonction pour contrôler l'activation du style "zèbré" au cahrgement de la page
function checkStripedTable() {
    striped = localStorage.getItem("striped");

    if(striped === "True") {
        // Tableau avec un tr séléctionné sur 2
        let tr_list = document.querySelectorAll('tr:nth-child(even)');

        // Parcourir chaques éléments dans le tableau
        tr_list.forEach(row => {
            // Appliquer le styla à chaques éléments
            row.style.backgroundColor = "#f2f2f2"
        });

        // Changer la couleur du bouton et le texte
        document.getElementById("btn_modal_settings").textContent = "Désactiver";
        document.getElementById("btn_modal_settings").style.color = "red";
    }
    else if(striped === "False") {
        // Tableau avec un tr séléctionné sur 2
        let tr_list = document.querySelectorAll('tr:nth-child(even)');

        // Parcourir chaques éléments
        tr_list.forEach(row => {
        // Appliquer le styla à chaques éléments
            row.style.backgroundColor = "white";
        });

        // Changer la couleur du bouton et le texte
        document.getElementById("btn_modal_settings").textContent = "Activer";
        document.getElementById("btn_modal_settings").style.color = "green";
    }
}

// Appliquer un filtre dans la table html commande et fournisseur
let search_input = document.getElementById("searche");  // Séléctionner l'input
let rows = document.getElementsByTagName('tr');
let table;

// Séléctionner la bonne table pour appliquer le filtre
if(localStorage.getItem("afficher fournisseur") === "False") {
    let table = document.getElementById("table-cmd");  // Séléctionner la table des commandes
}
else if(localStorage.getItem("afficher fournisseur") === "True") {
    let table = document.getElementById("tbl_fourn");  // Séléctionner la table des fournisseurs
}

// Écouter l'évenement "input" (à chaque saisie de texte)
search_input.addEventListener("input", function() {
    // Récupérer la valeur de l'input
    let search_input_value = this.value.toLowerCase();
    // console.log(search_input_value, table); // --> Pour du débug

    // Parcourir les rows de la table pour appliquer le filtre
    for(let i = 1; i < rows.length; i++) {
        let cells = rows[i].getElementsByTagName('td');
        let found = false;

        // Parcourir les cellules de chaque ligne
        for(let j = 0 ; j < cells.length; j++) {
            if(cells[j].textContent.toLowerCase().includes(search_input_value)) {
                found = true
            }
        }

        if(found) {
            rows[i].style.display = '';
        } else {
            rows[i].style.display = 'none';

        }
    }
});