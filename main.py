import random
from datetime import datetime, timedelta


# Ce programme génère des requêtes SQL d'insertion pour remplir une base de données d'un hopital fictif.
# Il utilise la bibliothèque Faker pour créer des noms réalistes dans différentes langues.
# Les fonctions génèrent des données pour les patients, contacts, factures, assurances, profils médicaux,
# antécédents, urgences, consultations, hospitalisations, prescriptions et commandes.
# Le résultat est écrit dans un fichier "dummy_generated.sql" selon le type de données demandé.


try:
    from faker import Faker
    fake = Faker('fr_FR')
    language = ['fr_CH', 'en_US', 'de_CH', 'it_IT', 'ar_EG', 'en_IN']
except ImportError:
    fake = None

def random_date(start, end):
    """Generate a random datetime between `start` and `end`"""
    return start + timedelta(
        seconds=random.randint(0, int((end - start).total_seconds())),
    )

def generate_names(n, start=1):
    global fake, language
    names = []
    for i in range(start, start + n):

        if fake:
            fake = Faker(random.choice(language))
            gender = random.choice(['M', 'F'])
            name = fake.name_male() if gender == 'M' else fake.name_female()
            langue = random.choice(['Français', 'Arabe', 'Espagnol', 'Anglais', 'Italien', 'Allemand', 'Tchèque', 'Russe', 'Somali', 'Malayalam'])
            names.append((name, gender, langue))

    return names

def generate_patients(n=5, start=1):
    names = generate_names(n, start)
    patients = []
    for i in range(n):
        name, sexe, langue = names[i]
        dob = datetime(1945, 1, 1) + timedelta(days=random.randint(0, 25000))
        age = (datetime.now() - dob).days // 365
        if age >= 70:
            hospitalise = random.choices(['O', 'N'], weights=[0.8, 0.2])[0]
        elif age < 25:
            hospitalise = random.choices(['O', 'N'], weights=[0.1, 0.9])[0]
        else:
            hospitalise = random.choice(['O', 'N'])
        patients.append(
            f"INSERT INTO Patient VALUES ({start + i}, '{name}', '{dob.date()}', '{sexe}', '{langue}', '{hospitalise}');"
        )
    return patients

def generate_contacts(n=5, start=1):
    contacts = []
    for i in range(n):
        cantons = [
            ("Zurich", 60),  
            ("Aargau", 20),  
            ("Schwyz", 10),  
            ("Zug", 10),     
            ("Thurgau", 8),  
            ("St. Gallen", 8),      
            ("Bern", 8),
            ("Vaud", 7),
            ("Geneva", 5),
            ("Lucerne", 5),
            ("Ticino", 3),
            ("Valais", 2),
            ("Neuchâtel", 2),
            ("Fribourg", 2),
            ("Jura", 1),
            ("Uri", 1),
            ("Obwalden", 1),
            ("Nidwalden", 1),
            ("Glarus", 1),
            ("Appenzell Innerrhoden", 1),
            ("Appenzell Ausserrhoden", 1),
            ("Basel-Stadt", 2),
            ("Basel-Landschaft", 2),
            ("Graubünden", 2),
            ("Solothurn", 2),
            ("Schaffhausen", 1)
        ]
        canton_names = [c[0] for c in cantons]
        canton_weights = [c[1] for c in cantons]
        adresse = random.choices(canton_names, weights=canton_weights, k=1)[0]
        telephone = f"06{random.randint(10000000,99999999)}"
        num_assurance = f"ASSUR{random.randint(100,999)}"
        contacts.append(
            f"INSERT INTO Contact VALUES ({start + i}, {start + i}, '{adresse}', '{telephone}', '{num_assurance}');"
        )
    return contacts

def generate_factures(n=5, start=1):
    factures = []
    base_date = datetime(2024, 5, 10, 9, 0, 0)
    for i in range(n):
        montant = round(random.uniform(100, 500), 2)
        date_ = base_date + timedelta(days=i, hours=i)
        factures.append(
            f"INSERT INTO Facture VALUES ({start + i}, {start + i}, {montant}, '{date_.strftime('%Y-%m-%d %H:%M:%S')}');"
        )
    return factures

def generate_assurances(n=5, start=1):
    descs = [
        "Assurance maladie", "Assurance privée", "Assurance internationale",
        "Assurance étudiante", "Assurance privée"
    ]
    assurances = []
    for i in range(n):
        assurances.append(
            f"INSERT INTO Assurance VALUES ({start + i}, {start + i}, '{descs[i % len(descs)]}');"
        )
    return assurances

def generate_profils(n=5, start=1):
    profils = []
    for i in range(n):
        profils.append(
            f"INSERT INTO Profil_médical VALUES ({start + i}, {start + i});"
        )
    return profils

def generate_antecedents(n=5, start=1):
    antecedents_list = [
        "Allergie pénicilline", "Asthme", "Hypertension", 
        "Aucun", "Diabète type 2"
    ]
    antecedents = []
    for i in range(n):
        antecedents.append(
            f"INSERT INTO Antécédents VALUES ({start + i}, {start + i}, '{antecedents_list[i % len(antecedents_list)]}');"
        )
    return antecedents
def generate_urgences(n=5, start=1, patients=0):
    urgences = []
    for i in range(1, n + 1):
        patient_id = random.randint(start, start + patients-2)
        medecin_id = random.choice([1, 4, 5, 6])
        start_date = datetime(2020, 1, 1)
        end_date = datetime.now()
        date_ = random_date(start_date, end_date)
        motifs = [
            "Crise asthme",
            "Douleur thoracique",
            "Fièvre élevée",
            "Blessure sportive",
            "Accident domestique",
            "Intoxication alimentaire",
            "Perte de connaissance",
            "Brûlure",
            "Fracture",
            "Malaise"
        ]
        motif = motifs[i % len(motifs)]
        urgences.append(
            f"INSERT INTO Urgence VALUES ({i}, {patient_id}, {medecin_id}, '{date_.strftime('%Y-%m-%d %H:%M:%S')}', '{motif}');"
        )
    return urgences

def generate_consultations(n=5, start=1, patients=0):
    consultations = []
    for i in range(n):
        patient_id = random.randint(1, patients)
        medecin_id = random.choice([1, 4, 5, 6])
        start_date = datetime(2020, 1, 1)
        end_date = datetime.now()
        date_ = random_date(start_date, end_date)
        motifs = [
            "Contrôle annuel",
            "Suivi diabète",
            "Consultation post-opératoire",
            "Douleur chronique",
            "Vaccination",
            "Bilan sanguin",
            "Prescription renouvellement",
            "Conseil nutritionnel",
            "Examen préventif",
            "Consultation générale"
        ]
        motif = motifs[i % len(motifs)]
        # id_consultation_ref: 10% chance to reference a previous consultation, else NULL
        if i > 0 and random.random() < 0.1:
            id_consultation_ref = "NULL"
        else:
            id_consultation_ref = "NULL"
        consultations.append(
            f"INSERT INTO Consultation VALUES ({i}, {patient_id}, {medecin_id}, '{date_.strftime('%Y-%m-%d %H:%M:%S')}', {id_consultation_ref}, '{motif}');"
        )
    return consultations

def generate_hospitalisations(n=5, start=1, patients=0):
    hospitalisations = []
    motifs = [
        "Observation post-opératoire",
        "Traitement infection",
        "Rééducation",
        "Surveillance cardiaque",
        "Chirurgie programmée",
        "Soins palliatifs",
        "Accident grave",
        "Complications diabète",
        "Transfusion sanguine",
        "Soins intensifs"
    ]
    for i in range(n):
        patient_id = random.randint(start, patients)
        medecin_id = random.choice([1, 4, 5, 6])
        chambre_id = random.randint(1, 2)
        infirmier_id = random.choice([2, 7, 8])
        motif = motifs[i % len(motifs)]
        hospitalisations.append(
            f"INSERT INTO Hospitalisation VALUES ({i+1}, {medecin_id}, {patient_id}, '{motif}', {chambre_id}, {infirmier_id});"
        )
    return hospitalisations

def generate_prescriptions(n=5, start=1, consultations=0):
    
    prescriptions = []
    instructions = [
        "Prendre 2x par jour",
        "Prendre après repas",
        "Prendre 1x par jour",
        "Prendre 3x par jour",
        "Prendre avant coucher",
        "Prendre avec beaucoup deau",
        "Prendre à jeun",
        "Prendre toutes les 8 heures",
        "Prendre en cas de douleur",
        "Prendre pendant 7 jours"
    ]
    for i in range(n):
        consultation_id = random.randint(1, consultations)
        desc = instructions[i % len(instructions)]
        prescriptions.append(
            f"INSERT INTO Prescription VALUES ({start+i+1}, {consultation_id}, '{desc}');"
        )
    return prescriptions

def generate_commandes(n=5, start=1, prescriptions=0):
    commandes = []
    for i in range(n):
        id_medicament = random.randint(1, 10)
        id_prescription = random.randint(1, prescriptions)
        commandes.append(
            f"INSERT INTO Commande VALUES ({start + i+1}, {id_medicament}, {id_prescription});"
        )
    return commandes
def main():
    n = 100
    i = 6
    nbr_patients = 1100
    demande = 'commandes'  # 'hspitalisations', 'urgences', 'consultations', 'patients', 'contacts', 'factures', 'assurances', 'profils', 'antecedents'
    
    if demande == 'urgences':
        lines = []
        lines += generate_urgences(n=100, start=1, patients=nbr_patients)
    elif demande == 'consultations':
        lines = []
        lines += generate_consultations(n=500, start=162, patients=nbr_patients)
    elif demande == 'hospitalisations':
        lines = []
        lines += generate_hospitalisations(n=100, start=1, patients=nbr_patients)
    elif demande == 'prescriptions':    
        lines = []
        lines += generate_prescriptions(n=250, start=5, consultations=500)
        
    elif demande == 'commandes':
        lines = []
        lines += generate_commandes(n=300, start=5, prescriptions=255)
    else:
        lines = []
        lines += ["-- Patients"]
        lines += generate_patients(n, start=i)
        lines += ["\n-- Contact"]
        lines += generate_contacts(n, start=i)
        lines += ["\n-- Facture"]
        lines += generate_factures(n, start=i)
        lines += ["\n-- Assurance"]
        lines += generate_assurances(n, start=i)
        lines += ["\n-- Profil_médical"]
        lines += generate_profils(n, start=i)
        lines += ["\n-- Antécédents"]
        lines += generate_antecedents(n, start=i)

    with open("dummy_generated.sql", "w", encoding="utf-8") as f:
        for line in lines:
            f.write(line + "\n")

if __name__ == "__main__":
    main()
    
