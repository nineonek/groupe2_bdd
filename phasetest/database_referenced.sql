CREATE TABLE Médicament (
    id_médicament INT PRIMARY KEY,
    nom VARCHAR(50),
    description TEXT
);

CREATE TABLE Patient (
    id_patient INT PRIMARY KEY,
    NomComplet VARCHAR(50),
    DATE_naissance DATE,
    sexe CHAR,
    langue VARCHAR(50),
    hospitalise CHAR
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
    num_licence VARCHAR(50),
    FOREIGN KEY (id_personnel) REFERENCES Personnel (id_personnel)
);

CREATE TABLE Infirmier (
    id_personnel INT PRIMARY KEY,
    niveau_certification VARCHAR(50),
    FOREIGN KEY (id_personnel) REFERENCES Personnel (id_personnel)
);

CREATE TABLE Intendance (
    id_personnel INT PRIMARY KEY,
    zone_attribuee VARCHAR(50),
    fonction VARCHAR(50),
    FOREIGN KEY (id_personnel) REFERENCES Personnel (id_personnel)
);

CREATE TABLE équipement (
    id_équipement INT PRIMARY KEY,
    nom VARCHAR(50),
    type VARCHAR(50)
);

CREATE TABLE Service (
    id_service INT PRIMARY KEY,
    nom_service VARCHAR(50),
    id_equipement_origine INT,
    id_equipement_attribue INT,
    FOREIGN KEY (id_equipement_origine) REFERENCES équipement (id_équipement),
    FOREIGN KEY (id_equipement_attribue) REFERENCES équipement (id_équipement)
);

CREATE TABLE Locaux (
    id_locaux INT PRIMARY KEY,
    id_service INT,
    localisation VARCHAR(50),
    fonctions VARCHAR(50),
    FOREIGN KEY (id_service) REFERENCES Service (id_service)
);

CREATE TABLE Stockage (
    id_locaux INT PRIMARY KEY,
    description TEXT,
    FOREIGN KEY (id_locaux) REFERENCES Locaux (id_locaux)
);

CREATE TABLE Chambre (
    id_chambre INT PRIMARY KEY,
    id_locaux INT,
    FOREIGN KEY (id_locaux) REFERENCES Locaux (id_locaux)
);

CREATE TABLE Consultation (
    id_consultation INT PRIMARY KEY,
    id_patient INT,
    id_médecin INT,
    date DATETIME,
    id_consultation_ref INT,
    motif TEXT,
    FOREIGN KEY (id_patient) REFERENCES Patient (id_patient),
    FOREIGN KEY (id_médecin) REFERENCES Médecin (id_personnel),
    FOREIGN KEY (id_consultation_ref) REFERENCES Consultation (id_consultation)
);

CREATE TABLE Prescription (
    id_prescription INT PRIMARY KEY,
    id_consultation INT,
    id_médicament INT,
    description TEXT,
    FOREIGN KEY (id_consultation) REFERENCES Consultation (id_consultation),
    FOREIGN KEY (id_médicament) REFERENCES Médicament (id_médicament)
);

CREATE TABLE Commande (
    id_commande INT PRIMARY KEY,
    id_médicament INT,
    id_prescription INT,
    FOREIGN KEY (id_médicament) REFERENCES Médicament (id_médicament),
    FOREIGN KEY (id_prescription) REFERENCES Prescription (id_prescription)
);

CREATE TABLE Contact (
    id_contact INT PRIMARY KEY,
    id_patient INT,
    adresse VARCHAR(50),
    telephone VARCHAR(50),
    num_assurance VARCHAR(50),
    FOREIGN KEY (id_patient) REFERENCES Patient (id_patient)
);

CREATE TABLE Facture (
    id_facture INT PRIMARY KEY,
    id_patient INT,
    montant FLOAT,
    date_ DATETIME,
    FOREIGN KEY (id_patient) REFERENCES Patient (id_patient)
);

CREATE TABLE Assurance (
    id_assurance INT PRIMARY KEY,
    id_facture INT,
    description TEXT,
    FOREIGN KEY (id_facture) REFERENCES Facture (id_facture)
);

CREATE TABLE Profil_médical (
    id_profil_médical INT PRIMARY KEY,
    id_patient INT,
    FOREIGN KEY (id_patient) REFERENCES Patient (id_patient)
);

CREATE TABLE Antécédents (
    id_antecedent INT PRIMARY KEY,
    id_profil_médical INT,
    traitements TEXT,
    FOREIGN KEY (id_profil_médical) REFERENCES Profil_médical (id_profil_médical)
);

CREATE TABLE Urgence (
    id_urgence INT PRIMARY KEY,
    id_patient INT,
    id_médecin INT,
    date DATETIME,
    description TEXT,
    FOREIGN KEY (id_patient) REFERENCES Patient (id_patient),
    FOREIGN KEY (id_médecin) REFERENCES Médecin (id_personnel)
);

CREATE TABLE Hospitalisation (
    id_hospitalisation INT PRIMARY KEY,
    id_médecin INT,
    id_patient INT,
    motif TEXT,
    id_chambre INT,
    id_infirmier INT,
    FOREIGN KEY (id_médecin) REFERENCES Médecin (id_personnel),
    FOREIGN KEY (id_patient) REFERENCES Patient (id_patient),
    FOREIGN KEY (id_chambre) REFERENCES Chambre (id_chambre),
    FOREIGN KEY (id_infirmier) REFERENCES Infirmier (id_personnel)
);

CREATE TABLE Suivi (
    id_hospitalisation INT,
    id_infirmier INT,
    PRIMARY KEY (id_hospitalisation, id_infirmier),
    FOREIGN KEY (id_hospitalisation) REFERENCES Hospitalisation (id_hospitalisation),
    FOREIGN KEY (id_infirmier) REFERENCES Infirmier (id_personnel)
);