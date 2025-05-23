--- Historique de médicament
SELECT
    m.nom AS NomMedicament,
    COUNT(pr.id_prescription) AS NombreDeUtilisations
FROM Médicament AS m
JOIN Commande as cm on m.id_médicament = cm.id_médicament
JOIN Prescription AS pr ON cm.id_prescription = pr.id_prescription
GROUP BY m.nom
ORDER BY NombreDeUtilisations DESC;


--- Suivi des prescriptions médicales par patient
SELECT
    m.nom AS NomMedicament,
    m.description AS DescriptionMedicament,
    pr.description AS DescriptionPrescription,
    cm.id_commande AS IdCommande 
FROM Médicament AS m
JOIN Commande AS cm ON m.id_médicament = cm.id_médicament 
JOIN prescription as pr on cm.id_prescription = pr.id_prescription
JOIN Consultation AS c ON pr.id_consultation = c.id_consultation
JOIN Patient AS pat ON c.id_patient = pat.id_patient
WHERE pat.id_patient = 1;


--- Comptabilise toutes les factures pour envoyer aux assurances
SELECT
    p.NomComplet,
    SUM(f.montant) AS MontantàPayer,
    SUM(CASE
        WHEN a.description IN ('Assurance internationale', 'Assurance étudiante') THEN f.montant
        ELSE f.montant * 0.5
    END) AS MontantAssuré
FROM Facture AS f
JOIN Assurance AS a ON f.id_facture = a.id_facture
JOIN Patient AS p ON f.id_patient = p.id_patient
GROUP BY p.NomComplet;

--- Nombre d’urgences mensuels
SELECT
    DATE_FORMAT(date, '%Y-%m') AS MoisDeLUrgence,
    COUNT(id_urgence) AS NombreTotalUrgences
FROM
    Urgence
GROUP BY
    MoisDeLUrgence
ORDER BY
    NombreTotalUrgences DESC;

---  Liste des patients avec des antécédents médicaux ayant eu au moins 2 hospitalisations en 1 an
SELECT
    p.NomComplet,
    a.traitements,
    COUNT(h.id_hospitalisation) AS NombreHospitalisationsRecentes
FROM
    Patient AS p
JOIN
    Profil_médical AS pm ON p.id_patient = pm.id_patient
JOIN
    Antécédents AS a ON pm.id_profil_médical = a.id_profil_médical
JOIN
    Hospitalisation AS h ON p.id_patient = h.id_patient
WHERE

    (a.traitements LIKE '%diabète%' OR a.traitements LIKE '%hypertension%')
    AND h.date_admission >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY
    p.NomComplet, a.traitements
HAVING
    COUNT(h.id_hospitalisation) >= 2
ORDER BY
	NombreHospitalisationsRecentes DESC;


--- Actualisation automatique du statut du patient
DELIMITER $$
CREATE TRIGGER trg_patient_hospitalise_on_urgence_admission
AFTER INSERT ON Urgence
FOR EACH ROW
BEGIN
    UPDATE Patient
    SET hospitalise = 'O'
    WHERE id_patient = NEW.id_patient
    AND hospitalise = 'N';
END$$
DELIMITER ;