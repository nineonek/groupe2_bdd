-- Équipement
INSERT INTO Équipement VALUES (1, 'Scanner', 'Imagerie');
INSERT INTO Équipement VALUES (2, 'Lit médical', 'Mobilier');

-- Service
INSERT INTO Service VALUES (1, 'Radiologie', 1, 2);
INSERT INTO Service VALUES (2, 'Urgences', 2, 1);

-- Locaux
INSERT INTO Locaux VALUES (1, 1, 'Bâtiment A', 'Radiologie');
INSERT INTO Locaux VALUES (2, 2, 'Bâtiment B', 'Urgences');

-- Chambre
INSERT INTO Chambre VALUES (1, 1);
INSERT INTO Chambre VALUES (2, 2);

-- Stockage
INSERT INTO Stockage VALUES (1, 'Stockage radiologie');
INSERT INTO Stockage VALUES (2, 'Stockage urgences');

-- Personnel
INSERT INTO Personnel VALUES (1, 'Martin', 'Paul', '2010-01-01', 3500, 'Radiologie', 'Français', 'Dr. House');
INSERT INTO Personnel VALUES (2, 'Durand', 'Sophie', '2015-03-15', 2800, 'Urgences', 'Français', 'Dr. House');
INSERT INTO Personnel VALUES (3, 'Lemoine', 'Pierre', '2018-06-20', 2000, 'Intendance', 'Français', 'Mme. Martin');

-- Médecin, Infirmier, Intendance
INSERT INTO Médecin VALUES (1, 'LIC12345');
INSERT INTO Infirmier VALUES (2, 'CertifA');
INSERT INTO Intendance VALUES (3, 'Zone 1', 'Nettoyage');

-- Patients
INSERT INTO Patient VALUES (1, 'Jean Dupont', '1980-05-12', 'M', 'Français', 'N');
INSERT INTO Patient VALUES (2, 'Marie Curie', '1990-11-23', 'F', 'Français', 'O');
INSERT INTO Patient VALUES (3, 'Ahmed Benali', '1975-07-22', 'M', 'Arabe', 'N');
INSERT INTO Patient VALUES (4, 'Lucie Martin', '2002-03-15', 'F', 'Français', 'O');
INSERT INTO Patient VALUES (5, 'Carlos Gomez', '1988-09-10', 'M', 'Espagnol', 'N');

-- Contact
INSERT INTO Contact VALUES (1, 1, 'Genève', '0600000001', 'ASSUR123');
INSERT INTO Contact VALUES (2, 2, 'Vaud', '0600000002', 'ASSUR456');
INSERT INTO Contact VALUES (3, 3, 'Valais', '0600000003', 'ASSUR789');
INSERT INTO Contact VALUES (4, 4, 'Fribourg', '0600000004', 'ASSUR321');
INSERT INTO Contact VALUES (5, 5, 'Neuchâtel', '0600000005', 'ASSUR654');

-- Facture
INSERT INTO Facture VALUES (1, 1, 250.50, '2024-05-10 09:00:00');
INSERT INTO Facture VALUES (2, 2, 400.00, '2024-05-11 10:00:00');
INSERT INTO Facture VALUES (3, 3, 180.00, '2024-05-12 12:00:00');
INSERT INTO Facture VALUES (4, 4, 320.00, '2024-05-13 13:00:00');
INSERT INTO Facture VALUES (5, 5, 210.00, '2024-05-14 14:00:00');

-- Assurance
INSERT INTO Assurance VALUES (1, 1, 'Assurance maladie');
INSERT INTO Assurance VALUES (2, 2, 'Assurance privée');
INSERT INTO Assurance VALUES (3, 3, 'Assurance internationale');
INSERT INTO Assurance VALUES (4, 4, 'Assurance étudiante');
INSERT INTO Assurance VALUES (5, 5, 'Assurance privée');

-- Profil_médical
INSERT INTO Profil_médical VALUES (1, 1);
INSERT INTO Profil_médical VALUES (2, 2);
INSERT INTO Profil_médical VALUES (3, 3);
INSERT INTO Profil_médical VALUES (4, 4);
INSERT INTO Profil_médical VALUES (5, 5);

-- Antécédents
INSERT INTO Antécédents VALUES (1, 1, 'Allergie pénicilline');
INSERT INTO Antécédents VALUES (2, 2, 'Asthme');
INSERT INTO Antécédents VALUES (3, 3, 'Hypertension');
INSERT INTO Antécédents VALUES (4, 4, 'Aucun');
INSERT INTO Antécédents VALUES (5, 5, 'Diabète type 2');

-- Médicament
INSERT INTO Médicament VALUES (1, 'Paracétamol', 'Antidouleur');
INSERT INTO Médicament VALUES (2, 'Ibuprofène', 'Anti-inflammatoire');
INSERT INTO Médicament VALUES (3, 'Amoxicilline', 'Antibiotique');
INSERT INTO Médicament VALUES (4, 'Aspirine', 'Antipyrétique');
INSERT INTO Médicament VALUES (5, 'Metformine', 'Antidiabétique');
INSERT INTO Médicament VALUES (6, 'Loratadine', 'Antihistaminique');
INSERT INTO Médicament VALUES (7, 'Oméprazole', 'Inhibiteur de la pompe à protons');
INSERT INTO Médicament VALUES (8, 'Salbutamol', 'Bronchodilatateur');
INSERT INTO Médicament VALUES (9, 'Simvastatine', 'Hypocholestérolémiant');
INSERT INTO Médicament VALUES (10, 'Diazépam', 'Anxiolytique');

-- Consultation
INSERT INTO Consultation VALUES (1, 1, 1, '2024-05-12 14:00:00', NULL, 'Fièvre');
INSERT INTO Consultation VALUES (2, 2, 1, '2024-05-13 15:00:00', 1, 'Douleurs');
INSERT INTO Consultation VALUES (3, 3, 1, '2024-05-15 10:00:00', NULL, 'Contrôle annuel');
INSERT INTO Consultation VALUES (4, 4, 1, '2024-05-16 11:00:00', NULL, 'Vaccination');
INSERT INTO Consultation VALUES (5, 5, 1, '2024-05-17 12:00:00', NULL, 'Douleurs abdominales');

-- Prescription
INSERT INTO Prescription VALUES (1, 1, 'Prendre 2x par jour');
INSERT INTO Prescription VALUES (2, 2, 'Prendre après repas');
INSERT INTO Prescription VALUES (3, 3, 'Prendre 1x par jour');
INSERT INTO Prescription VALUES (4, 4, 'Prendre 3x par jour');
INSERT INTO Prescription VALUES (5, 5, 'Prendre après repas');

-- Commande
INSERT INTO Commande VALUES (1, 1, 1);
INSERT INTO Commande VALUES (2, 2, 2);
INSERT INTO Commande VALUES (3, 1, 3);
INSERT INTO Commande VALUES (4, 2, 4);
INSERT INTO Commande VALUES (5, 1, 5);


-- Urgence
INSERT INTO Urgence VALUES (1, 2, 1, '2024-05-14 18:00:00', 'Crise asthme');
INSERT INTO Urgence VALUES (2, 3, 1, '2024-05-18 18:00:00', 'Douleur thoracique');
INSERT INTO Urgence VALUES (3, 4, 1, '2024-05-18 19:00:00', 'Fièvre élevée');
INSERT INTO Urgence VALUES (4, 5, 1, '2024-05-18 20:00:00', 'Blessure sportive');

-- Hospitalisation
INSERT INTO Hospitalisation VALUES (1, 1, 2, 'Observation', 1, 2);

-- Suivi
INSERT INTO Suivi VALUES (1, 2);