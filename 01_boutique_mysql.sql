-- BOUTIQUE : jeu de donnees commun aux seances 1, 2 et 3 (MySQL 8+)
-- ATTENTION : ce fichier supprime et recree la base boutique.
-- Tous les montants sont en MAD, les emails sont fictifs.
CREATE DATABASE IF NOT EXISTS boutique CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE boutique;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS paiements;
DROP TABLE IF EXISTS lignes_commande;
DROP TABLE IF EXISTS commandes;
DROP TABLE IF EXISTS produits;
DROP TABLE IF EXISTS clients;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE clients (
 id INT PRIMARY KEY, prenom VARCHAR(60) NOT NULL, nom VARCHAR(70) NOT NULL,
 ville VARCHAR(80) NOT NULL, email VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB;
CREATE TABLE produits (
 id INT PRIMARY KEY, nom VARCHAR(120) NOT NULL, categorie VARCHAR(70) NOT NULL,
 prix DECIMAL(10,2) NOT NULL, stock INT NOT NULL,
 CONSTRAINT chk_produits_prix CHECK (prix >= 0),
 CONSTRAINT chk_produits_stock CHECK (stock >= 0)
) ENGINE=InnoDB;
CREATE TABLE commandes (
 id INT PRIMARY KEY, client_id INT NOT NULL, date_commande DATE NOT NULL,
 statut VARCHAR(30) NOT NULL, total DECIMAL(12,2) NOT NULL,
 CONSTRAINT fk_commandes_client FOREIGN KEY (client_id) REFERENCES clients(id)
) ENGINE=InnoDB;
CREATE TABLE lignes_commande (
 id INT PRIMARY KEY, commande_id INT NOT NULL, produit_id INT NOT NULL,
 quantite INT NOT NULL, prix_unitaire DECIMAL(10,2) NOT NULL,
 CONSTRAINT fk_lignes_commande FOREIGN KEY (commande_id) REFERENCES commandes(id),
 CONSTRAINT fk_lignes_produit FOREIGN KEY (produit_id) REFERENCES produits(id)
) ENGINE=InnoDB;
CREATE TABLE paiements (
 id INT PRIMARY KEY, commande_id INT NOT NULL, date_paiement DATE NOT NULL,
 mode_paiement VARCHAR(30) NOT NULL, montant DECIMAL(12,2) NOT NULL,
 statut VARCHAR(30) NOT NULL,
 CONSTRAINT fk_paiement_commande FOREIGN KEY (commande_id) REFERENCES commandes(id)
) ENGINE=InnoDB;

-- clients: 12 enregistrements
INSERT INTO clients (id, prenom, nom, ville, email) VALUES
 (1, 'Amal', 'Benali', 'Rabat', 'amal@example.test'),
 (2, 'Youssef', 'Amrani', 'Salé', 'youssef@example.test'),
 (3, 'Salma', 'Idrissi', 'Casablanca', 'salma@example.test'),
 (4, 'Omar', 'El Fassi', 'Marrakech', 'omar@example.test'),
 (5, 'Hajar', 'Alaoui', 'Fès', 'hajar@example.test'),
 (6, 'Hamza', 'Berrada', 'Rabat', 'hamza@example.test'),
 (7, 'Lina', 'Tazi', 'Tanger', 'lina@example.test'),
 (8, 'Adam', 'Karimi', 'Agadir', 'adam@example.test'),
 (9, 'Nadia', 'Chraibi', 'Meknès', 'nadia@example.test'),
 (10, 'Mehdi', 'Kabbaj', 'Casablanca', 'mehdi@example.test'),
 (11, 'Imane', 'Slaoui', 'Salé', 'imane@example.test'),
 (12, 'Sara', 'Mansouri', 'Rabat', 'sara@example.test');

-- produits: 12 enregistrements
INSERT INTO produits (id, nom, categorie, prix, stock) VALUES
 (1, 'Clavier', 'Accessoires', 150, 12),
 (2, 'Souris', 'Accessoires', 90, 25),
 (3, 'Écran', 'Informatique', 1200, 9),
 (4, 'Ordinateur portable', 'Informatique', 6500, 7),
 (5, 'Clé USB', 'Stockage', 80, 40),
 (6, 'Disque SSD', 'Stockage', 800, 15),
 (7, 'Imprimante', 'Périphériques', 1100, 6),
 (8, 'Tapis de souris', 'Accessoires', 60, 30),
 (9, 'Enceintes', 'Audio', 320, 14),
 (10, 'Microphone', 'Audio', 450, 8),
 (11, 'Support PC', 'Accessoires', 220, 16),
 (12, 'Routeur Wi-Fi', 'Réseau', 600, 10);

-- commandes: 20 enregistrements
INSERT INTO commandes (id, client_id, date_commande, statut, total) VALUES
 (1, 1, '2026-09-03', 'livree', 950),
 (2, 2, '2026-09-05', 'livree', 1260),
 (3, 3, '2026-09-07', 'en_preparation', 610),
 (4, 4, '2026-09-09', 'en_attente', 2300),
 (5, 5, '2026-09-11', 'annulee', 410),
 (6, 6, '2026-09-13', 'livree', 6940),
 (7, 7, '2026-09-15', 'livree', 950),
 (8, 8, '2026-09-17', 'en_preparation', 1320),
 (9, 9, '2026-09-19', 'en_attente', 610),
 (10, 10, '2026-09-21', 'annulee', 1700),
 (11, 11, '2026-09-23', 'livree', 410),
 (12, 12, '2026-09-25', 'livree', 13440),
 (13, 1, '2026-09-27', 'en_preparation', 950),
 (14, 2, '2026-09-29', 'en_attente', 1260),
 (15, 3, '2026-10-01', 'annulee', 610),
 (16, 4, '2026-10-03', 'livree', 2300),
 (17, 5, '2026-10-05', 'livree', 410),
 (18, 6, '2026-10-07', 'en_preparation', 6940),
 (19, 12, '2026-10-09', 'en_attente', 950),
 (20, 8, '2026-10-11', 'annulee', 1320);

-- lignes_commande: 40 enregistrements
INSERT INTO lignes_commande (id, commande_id, produit_id, quantite, prix_unitaire) VALUES
 (1, 1, 1, 1, 150),
 (2, 1, 6, 1, 800),
 (3, 2, 3, 1, 1200),
 (4, 2, 8, 1, 60),
 (5, 3, 5, 2, 80),
 (6, 3, 10, 1, 450),
 (7, 4, 7, 1, 1100),
 (8, 4, 12, 2, 600),
 (9, 5, 9, 1, 320),
 (10, 5, 2, 1, 90),
 (11, 6, 11, 2, 220),
 (12, 6, 4, 1, 6500),
 (13, 7, 1, 1, 150),
 (14, 7, 6, 1, 800),
 (15, 8, 3, 1, 1200),
 (16, 8, 8, 2, 60),
 (17, 9, 5, 2, 80),
 (18, 9, 10, 1, 450),
 (19, 10, 7, 1, 1100),
 (20, 10, 12, 1, 600),
 (21, 11, 9, 1, 320),
 (22, 11, 2, 1, 90),
 (23, 12, 11, 2, 220),
 (24, 12, 4, 2, 6500),
 (25, 13, 1, 1, 150),
 (26, 13, 6, 1, 800),
 (27, 14, 3, 1, 1200),
 (28, 14, 8, 1, 60),
 (29, 15, 5, 2, 80),
 (30, 15, 10, 1, 450),
 (31, 16, 7, 1, 1100),
 (32, 16, 12, 2, 600),
 (33, 17, 9, 1, 320),
 (34, 17, 2, 1, 90),
 (35, 18, 11, 2, 220),
 (36, 18, 4, 1, 6500),
 (37, 19, 1, 1, 150),
 (38, 19, 6, 1, 800),
 (39, 20, 3, 1, 1200),
 (40, 20, 8, 2, 60);

-- paiements: 14 enregistrements
INSERT INTO paiements (id, commande_id, date_paiement, mode_paiement, montant, statut) VALUES
 (1, 1, '2026-09-03', 'carte', 950, 'valide'),
 (2, 2, '2026-09-05', 'especes', 1260, 'valide'),
 (3, 3, '2026-09-07', 'carte', 610, 'valide'),
 (4, 4, '2026-09-09', 'virement', 2300, 'en_attente'),
 (5, 6, '2026-09-13', 'especes', 6940, 'valide'),
 (6, 7, '2026-09-15', 'carte', 950, 'valide'),
 (7, 8, '2026-09-17', 'especes', 1320, 'valide'),
 (8, 11, '2026-09-23', 'carte', 410, 'valide'),
 (9, 12, '2026-09-25', 'especes', 13440, 'valide'),
 (10, 13, '2026-09-27', 'carte', 950, 'valide'),
 (11, 14, '2026-09-29', 'virement', 1260, 'en_attente'),
 (12, 16, '2026-10-03', 'especes', 2300, 'valide'),
 (13, 17, '2026-10-05', 'carte', 410, 'valide'),
 (14, 18, '2026-10-07', 'especes', 6940, 'valide');

-- Verifications rapides
SELECT 'clients' AS table_nom, COUNT(*) AS nb FROM clients
UNION ALL SELECT 'produits', COUNT(*) FROM produits
UNION ALL SELECT 'commandes', COUNT(*) FROM commandes
UNION ALL SELECT 'lignes_commande', COUNT(*) FROM lignes_commande
UNION ALL SELECT 'paiements', COUNT(*) FROM paiements;

-- Exercice seance 1 (HAVING) : les commandes de statut annulee
-- sont ici incluses dans le total, comme dans le support de cours.
SELECT c.nom, SUM(o.total) AS montant
FROM clients c JOIN commandes o ON o.client_id=c.id
GROUP BY c.id,c.nom
HAVING SUM(o.total)>300;
