import streamlit as st
import sqlite3
from datetime import datetime
from random import randint
# Connexion à la base de données SQLite
DB_FILE = 'hospital_project.db'

def get_connection():
    return sqlite3.connect(DB_FILE)

def fetch_data(query, params=()):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    rows = cursor.fetchall()
    conn.close()
    return rows

def execute_query(query, params):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    conn.commit()
    conn.close()

def get_next_id(table, id_col):
    result = fetch_data(f"SELECT MAX({id_col}) FROM {table}")
    max_id = result[0][0] if result and result[0][0] is not None else 0
    return max_id + 1

st.title("🏥 Système de Gestion Hospitalière")

menu = st.sidebar.selectbox(
    "Sélectionnez une action",
    [        
        "Enregistrer un Patient",
        "Ajouter une Hospitalisation",
        "Ajouter une Urgence",
        "Ajouter une Consultation",
        "Voir les Données",
        "Statistiques & Requêtes"

    ]
)



if menu == "Ajouter une Hospitalisation":
    st.subheader("➕ Ajouter une Hospitalisation")

    # Récupérer les données des clés étrangères
    patients = fetch_data("SELECT id_patient, NomComplet FROM Patient")
    Médecins = fetch_data("SELECT id_personnel, num_licence FROM Médecin")
    infirmiers = fetch_data("SELECT id_personnel, niveau_certification FROM Infirmier")
    chambres = fetch_data("SELECT id_chambre FROM Chambre")

    selected_patient = st.selectbox("Patient", patients, format_func=lambda x: f"{x[0]} - {x[1]}")
    selected_Médecin = st.selectbox("Médecin", Médecins, format_func=lambda x: f"{x[0]} - {x[1]}")
    selected_infirmier = st.selectbox("Infirmier", infirmiers, format_func=lambda x: f"{x[0]} - {x[1]}")
    selected_chambre = st.selectbox("Chambre", [c[0] for c in chambres])

    motif = st.text_area("Motif")

    if st.button("📥 Enregistrer l'Hospitalisation"):
        next_id = get_next_id("Hospitalisation", "id_hospitalisation")
        execute_query(
            "INSERT INTO Hospitalisation (id_hospitalisation, id_médecin, id_patient, motif, id_chambre, id_infirmier) VALUES (?, ?, ?, ?, ?, ?)",
            (next_id, selected_Médecin[0], selected_patient[0], motif, selected_chambre, selected_infirmier[0])
        )
        st.success("Hospitalisation enregistrée avec succès.")

elif menu == "Ajouter une Urgence":
    st.subheader("🚨 Ajouter une Urgence")

    patients = fetch_data("SELECT id_patient, NomComplet FROM Patient")
    Médecins = fetch_data("SELECT id_personnel, num_licence FROM Médecin")

    selected_patient = st.selectbox("Patient", patients, format_func=lambda x: f"{x[0]} - {x[1]}")
    selected_Médecin = st.selectbox("Médecin", Médecins, format_func=lambda x: f"{x[0]} - {x[1]}")
    date_urgence = st.date_input("Date")
    time_urgence = st.time_input("Heure")
    description = st.text_area("Description de l'urgence")

    full_datetime = datetime.combine(date_urgence, time_urgence)

    if st.button("📥 Enregistrer l'Urgence"):
        next_id = get_next_id("Urgence", "id_urgence")
        execute_query(
            "INSERT INTO Urgence (id_urgence, id_patient, id_médecin, date, description) VALUES (?, ?, ?, ?, ?)",
            (next_id, selected_patient[0], selected_Médecin[0], full_datetime, description)
        )
        st.success("Urgence enregistrée avec succès.")

elif menu == "Ajouter une Consultation":
    st.subheader("🩺 Ajouter une Consultation")

    patients = fetch_data("SELECT id_patient, NomComplet FROM Patient")
    Médecins = fetch_data("SELECT id_personnel, num_licence FROM Médecin")
    consultations = fetch_data("SELECT id_consultation, motif FROM Consultation")

    selected_patient = st.selectbox("Patient", patients, format_func=lambda x: f"{x[0]} - {x[1]}")
    selected_Médecin = st.selectbox("Médecin", Médecins, format_func=lambda x: f"{x[0]} - {x[1]}")
    date_consult = st.date_input("Date de la consultation")
    time_consult = st.time_input("Heure de la consultation")
    motif = st.text_area("Motif de la consultation")
    selected_ref = st.selectbox(
        "Consultation de référence (optionnel)", 
        [("", "")] + consultations, 
        format_func=lambda x: f"{x[0]} - {x[1]}" if x[0] != "" else "Aucune"
    )

    full_datetime = datetime.combine(date_consult, time_consult)
    id_consultation_ref = selected_ref[0] if selected_ref[0] != "" else None

    if st.button("📥 Enregistrer la Consultation"):
        next_id = get_next_id("Consultation", "id_consultation")
        execute_query(
            "INSERT INTO Consultation (id_consultation, id_patient, id_médecin, date, id_consultation_ref, motif) VALUES (?, ?, ?, ?, ?, ?)",
            (next_id, selected_patient[0], selected_Médecin[0], full_datetime, id_consultation_ref, motif)
        )
        st.success("Consultation enregistrée avec succès.")

elif menu == "Enregistrer un Patient":
    st.subheader("🧑‍⚕️ Enregistrer un Patient")

    NomComplet = st.text_input("Nom Complet")
    date_naissance = st.date_input("Date de Naissance")
    sexe = st.selectbox("Sexe", ["Masculin", "Féminin"])
    if sexe == "Masculin":
        sexe = "M"
    else:
        sexe = "F"
    langue = st.selectbox("Langue", ['Français', 'Arabe', 'Espagnol', 'Anglais', 'Italien', 'Allemand', 'Tchèque', 'Russe'])
    Hospitalise = st.selectbox("Hospitalisé", ['Oui', 'Non'])
    if Hospitalise == "Oui":
        Hospitalise = "O"
    else:
        Hospitalise = "N"
    
    adresse = st.selectbox("Canton", [
        "Zurich",
        "Aargau",
        "Schwyz",
        "Zug",
        "Thurgau",
        "St. Gallen",
        "Bern",
        "Vaud",
        "Geneva",
        "Lucerne",
        "Ticino",
        "Valais",
        "Neuchâtel",
        "Fribourg",
        "Jura",
        "Uri",
        "Obwalden",
        "Nidwalden",
        "Glarus",
        "Appenzell Innerrhoden",
        "Appenzell Ausserrhoden",
        "Basel-Stadt",
        "Basel-Landschaft",
        "Graubünden",
        "Solothurn",
        "Schaffhausen"
    ])
    telephone = st.text_input("Téléphone")
    if st.button("📥 Enregistrer le Patient"):
        next_id_patient = get_next_id("Patient", "id_patient")
        next_id_contact = get_next_id("Contact", "id_contact")
        execute_query(
            "INSERT INTO contact ('id_contact', 'id_patient', 'adresse', 'telephone', 'num_assurance') VALUES (?, ?, ?, ?, ?)",
            (next_id_contact, next_id_patient, adresse, telephone, f'ASSUR{randint(1000, 9999)}')
        )
        execute_query(
            "INSERT INTO patient ('id_patient', 'NomComplet', 'DATE_naissance', 'sexe', 'langue', 'hospitalise') VALUES (?, ?, ?, ?, ?, ?)",
            (next_id_patient, NomComplet, date_naissance, sexe, langue, Hospitalise)
        )
        st.success("Patient enregistré avec succès.")

elif menu == "Voir les Données":
    st.subheader("📄 Voir les Données")
    table = st.selectbox("Choisir la table", ["Hospitalisation", "Urgence", "Consultation", "Patient", "Médecin"])

    if st.button("🔍 Afficher") or "rows" in st.session_state:
        # session_state to persist rows after button click
        rows = fetch_data(f"SELECT * FROM {table}")
        st.session_state["rows"] = rows
        st.session_state["table"] = table
    else:
        rows = st.session_state.get("rows", [])
        table = st.session_state.get("table", table)

    if rows:
        st.dataframe(rows)
        id_col = [desc[0] for desc in get_connection().execute(f"PRAGMA table_info({table})")][0]
        ids = [row[0] for row in rows]
        selected_id = st.selectbox(f"ID à supprimer dans {table}", ids, key=f"delete_{table}")

        if st.button("🗑️ Supprimer la ligne sélectionnée"):
            execute_query(f"DELETE FROM {table} WHERE {f'id_{table}'} = ?", (selected_id,))
            st.success(f"Ligne avec ID {selected_id} supprimée de {table}.")
            st.session_state["rows"] = fetch_data(f"SELECT * FROM {table}")
            
            
elif menu == "Statistiques & Requêtes":
    st.subheader("📊 Statistiques & Requêtes SQL")
    
    # Charger toutes les requêtes SQL depuis le fichier groupe2_requetes.sql
    def load_requests_from_file(filename):
        with open(filename, "r", encoding="utf-8") as f:
            content = f.read()
        # Séparer les requêtes par ';' (en ignorant les lignes vides et commentaires)
        requests = [req.strip() for req in content.split(";") if req.strip() and not req.strip().startswith("--")]
        return requests

    requetes = {}
    with open("groupe2_requetes.sql", "r", encoding="utf-8") as f:
        lines = f.readlines()
    current_key = None
    current_query = []
    for line in lines:
        if line.strip().startswith("-"):
            if current_key and current_query:
                requetes[current_key] = "".join(current_query).strip()
                current_query = []
            current_key = line.strip().lstrip("-").strip()
        else:
            current_query.append(line)
    if current_key and current_query:
        requetes[current_key] = "".join(current_query).strip()
        
    choix = st.selectbox("Choisissez une requête", list(requetes.keys()))
    if choix == 'Suivi des prescriptions médicales par patient':
        patient_id = st.selectbox("Sélectionnez un ID de patient", [row[0] for row in fetch_data("SELECT id_patient FROM Patient")])
        if st.button("Exécuter la requête pour le patient sélectionné"):
            request = f"""
SELECT
    m.nom AS NomMedicament,
    m.description AS DescriptionMedicament,
    pr.description AS DescriptionPrescription,
    cm.id_commande AS IdCommande 
FROM Médicament AS m
LEFT JOIN Commande AS cm ON m.id_médicament = cm.id_médicament 
LEFT JOIN prescription as pr on cm.id_prescription = pr.id_prescription
LEFT JOIN Consultation AS c ON pr.id_consultation = c.id_consultation
LEFT JOIN Patient AS pat ON c.id_patient = pat.id_patient
WHERE pat.id_patient = 1;
"""        
            result = fetch_data(request)
            st.write(f"Résultat pour : **{choix}**")
            st.dataframe(result)
    else:
        if st.button("Exécuter la requête"):
            result = fetch_data(requetes[choix])
            st.write(f"Résultat pour : **{choix}**")
            st.dataframe(result)