CREATE TABLE Médicament (
    id_médicament INT PRIMARY KEY,
    nom VARCHAR(50),
    description TEXT
);

CREATE TABLE Prescription (
    id_prescription INT PRIMARY KEY,
    id_consultation INT,
    description TEXT
);

CREATE TABLE Commande (
    id_commande INT PRIMARY KEY,
    id_médicament INT,
    id_prescription INT
);

CREATE TABLE Consultation (
    id_consultation INT PRIMARY KEY,
    id_patient INT,
    id_médecin INT,
    date DATETIME,
    id_consultation_ref INT,
    motif TEXT
);

CREATE TABLE Patient (
    id_patient INT PRIMARY KEY,
    NomComplet VARCHAR(50),
    DATE_naissance DATE,
    sexe CHAR,
    langue VARCHAR(50),
    hospitalise CHAR
);

CREATE TABLE Contact (
    id_contact INT PRIMARY KEY,
    id_patient INT,
    adresse VARCHAR(50),
    telephone VARCHAR(50),
    num_assurance VARCHAR(50)
);

CREATE TABLE Facture (
    id_facture INT PRIMARY KEY,
    id_patient INT,
    montant FLOAT,
    date_ DATETIME
);
CREATE TABLE Assurance (
    id_assurance INT PRIMARY KEY,
    id_facture INT,
    description TEXT
);

CREATE TABLE Profil_médical (
    id_profil_médical INT PRIMARY KEY,
    id_patient INT
);

CREATE TABLE Antécédents (
    id_antecedent INT PRIMARY KEY,
    id_profil_médical INT,
    traitements TEXT
);

CREATE TABLE Urgence (
    id_urgence INT PRIMARY KEY,
    id_patient INT,
    id_médecin INT,
    date DATETIME,
    description TEXT
);

CREATE TABLE Personnel (
    id_personnel INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    DATE_embauche DATE,
    salaire FLOAT,
    affectation_specialite VARCHAR(50),
    langue VARCHAR(50),
    responsable VARCHAR(50)
);

CREATE TABLE Médecin (
    id_personnel INT PRIMARY KEY,
    num_licence VARCHAR(50)
);

CREATE TABLE Infirmier (
    id_personnel INT PRIMARY KEY,
    niveau_certification VARCHAR(50)
);

CREATE TABLE Intendance (
    id_personnel INT PRIMARY KEY,
    zone_attribuee VARCHAR(50),
    fonction VARCHAR(50)
);

CREATE TABLE Hospitalisation (
    id_hospitalisation INT PRIMARY KEY,
    id_médecin INT,
    id_patient INT,
    motif TEXT,
    id_chambre INT,
    id_infirmier INT
);

CREATE TABLE Suivi (
    id_hospitalisation INT,
    id_infirmier INT,
    PRIMARY KEY (id_hospitalisation, id_infirmier)
);

CREATE TABLE Chambre (
    id_chambre INT PRIMARY KEY,
    id_locaux INT
);

CREATE TABLE Locaux (
    id_locaux INT PRIMARY KEY,
    id_service INT,
    localisation VARCHAR(50),
    fonctions VARCHAR(50)
);

CREATE TABLE Stockage (
    id_locaux INT PRIMARY KEY,
    description TEXT
);

CREATE TABLE Service (
    id_service INT PRIMARY KEY,
    nom_service VARCHAR(50),
    id_equipement_origine INT,
    id_equipement_attribue INT
);


CREATE TABLE Équipement (
    id_équipement INT PRIMARY KEY,
    nom VARCHAR(50),
    type VARCHAR(50)
);


-- Adding foreign key constraints

-- Commande constraints
ALTER TABLE Commande 
    ADD CONSTRAINT FK_COMMANDE_MEDICAMENT
    FOREIGN KEY (id_médicament) 
    REFERENCES Médicament (id_médicament);

ALTER TABLE Commande
    ADD CONSTRAINT FK_COMMANDE_PRESCRIPTION
    FOREIGN KEY (id_prescription) 
    REFERENCES Prescription (id_prescription);

-- prescription constraints

ALTER TABLE Prescription 
    ADD CONSTRAINT FK_PRESCRIPTION_CONSULTATION
    FOREIGN KEY (id_consultation) 
    REFERENCES Consultation (id_consultation);

-- Removed invalid FK_PRESCRIPTION_CONSULTATION: Prescription does not have id_consultation, and Médicament does not have id_consultation.

-- Consultation constraints
ALTER TABLE Consultation 
    ADD CONSTRAINT FK_CONSULTATION_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);

ALTER TABLE Consultation 
    ADD CONSTRAINT FK_CONSULTATION_MEDECIN
    FOREIGN KEY (id_médecin) 
    REFERENCES Médecin (id_personnel);

ALTER TABLE Consultation 
    ADD CONSTRAINT FK_CONSULTATION_REF
    FOREIGN KEY (id_consultation_ref) 
    REFERENCES Consultation (id_consultation);

-- Contact constraint
ALTER TABLE Contact 
    ADD CONSTRAINT FK_CONTACT_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);

-- Facture constraint
ALTER TABLE Facture 
    ADD CONSTRAINT FK_FACTURE_PATIENT
    FOREIGN KEY (id_patient)
    REFERENCES Patient (id_patient);

-- Assurance constraint
ALTER TABLE Assurance 
    ADD CONSTRAINT FK_ASSURANCE_FACTURE
    FOREIGN KEY (id_facture)
    REFERENCES Facture (id_facture);

-- Profil_médical constraint
ALTER TABLE Profil_médical 
    ADD CONSTRAINT FK_PROFIL_MEDICAL_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);

-- Antécédents constraint
ALTER TABLE Antécédents 
    ADD CONSTRAINT FK_ANTECEDENTS_PROFIL_MEDICAL
    FOREIGN KEY (id_profil_médical) 
    REFERENCES Profil_médical (id_profil_médical);

-- Urgence constraint
ALTER TABLE Urgence 
    ADD CONSTRAINT FK_URGENCE_MEDECIN
    FOREIGN KEY (id_médecin) 
    REFERENCES Médecin (id_personnel);

ALTER TABLE Urgence 
    ADD CONSTRAINT FK_URGENCE_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);

-- Médecin constraint
ALTER TABLE Médecin 
    ADD CONSTRAINT FK_MEDECIN_PERSONNEL
    FOREIGN KEY (id_personnel) 
    REFERENCES Personnel (id_personnel);

-- Infirmier constraint
ALTER TABLE Infirmier 
    ADD CONSTRAINT FK_INFIRMIER_PERSONNEL
    FOREIGN KEY (id_personnel) 
    REFERENCES Personnel (id_personnel);

-- Intendance constraint
ALTER TABLE Intendance 
    ADD CONSTRAINT FK_INTENDANCE_PERSONNEL
    FOREIGN KEY (id_personnel) 
    REFERENCES Personnel (id_personnel);

-- Hospitalisation constraints
ALTER TABLE Hospitalisation 
    ADD CONSTRAINT FK_HOSPITALISATION_MEDECIN
    FOREIGN KEY (id_médecin) 
    REFERENCES Médecin (id_personnel);

ALTER TABLE Hospitalisation 
    ADD CONSTRAINT FK_HOSPITALISATION_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);

ALTER TABLE Hospitalisation 
    ADD CONSTRAINT FK_HOSPITALISATION_CHAMBRE
    FOREIGN KEY (id_chambre) 
    REFERENCES Chambre (id_chambre);

ALTER TABLE Hospitalisation
    ADD CONSTRAINT FK_HOSPITALISATION_INFIRMIER
    FOREIGN KEY (id_infirmier) 
    REFERENCES Infirmier (id_personnel);

-- Suivi constraints
ALTER TABLE Suivi 
    ADD CONSTRAINT FK_SUIVI_HOSPITALISATION
    FOREIGN KEY (id_hospitalisation) 
    REFERENCES Hospitalisation (id_hospitalisation);

ALTER TABLE Suivi 
    ADD CONSTRAINT FK_SUIVI_INFIRMIER
    FOREIGN KEY (id_infirmier) 
    REFERENCES Infirmier (id_personnel);

-- Chambre constraints
ALTER TABLE Chambre 
    ADD CONSTRAINT FK_CHAMBRE_LOCAUX
    FOREIGN KEY (id_locaux) 
    REFERENCES Locaux (id_locaux);

-- Locaux constraint
ALTER TABLE Locaux 
    ADD CONSTRAINT FK_LOCAUX_SERVICE
    FOREIGN KEY (id_service) 
    REFERENCES Service (id_service);


-- Service constraint
ALTER TABLE Service 
    ADD CONSTRAINT FK_SERVICE_EQUIPEMENT_ORIGINE
    FOREIGN KEY (id_equipement_origine)
    REFERENCES Équipement (id_équipement);
ALTER TABLE Service
    ADD CONSTRAINT FK_SERVICE_EQUIPEMENT_ATTRIBUE
    FOREIGN KEY (id_equipement_attribue)
    REFERENCES Équipement (id_équipement);

-- Stockage constraint
ALTER TABLE Stockage 
    ADD CONSTRAINT FK_STOCKAGE_LOCAUX
    FOREIGN KEY (id_locaux) 
    REFERENCES Locaux (id_locaux);






