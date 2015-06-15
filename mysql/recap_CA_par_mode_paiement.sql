--
-- name : bilan_z.sql
-- desc : récapitulatif des encaissements classés par moyen de paiement
--
-- params :
--  :du = la date de debut
--  :au = la date de fin
--  :numero = id du point de vente

SELECT 
	ventes.id_moyen_paiement AS id_moyen, 
	moyens_paiement.nom AS moyen,
	COUNT(vendus.id) AS quantite_vendue, 
	SUM(vendus.prix*vendus.quantite) AS total, 
	SUM(vendus.remboursement) AS remboursement 
FROM 
	ventes,
	vendus,
	moyens_paiement 
WHERE 
	vendus.id_vente = ventes.id  
   AND moyens_paiement.id = ventes.id_moyen_paiement 
   AND DATE(vendus.timestamp) BETWEEN :du AND :au 
   AND ventes.id_point_vente  = :numero
GROUP BY ventes.id_moyen_paiement;

