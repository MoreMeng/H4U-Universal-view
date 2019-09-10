CREATE VIEW [dbo].[h4u_allergy]
AS
SELECT ltrim(hn) AS hn,
	rtrim(i.name) AS drug_name,
	rtrim(alergyNote) + ' (' + causality + ')' AS symptom
FROM medalery m(NOLOCK)
LEFT JOIN Med_inv i ON m.medCode = i.code
	AND i.site = '1'
WHERE (
		delFlag IS NULL
		OR delFlag <> 'Y'
		)