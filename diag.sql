CREATE VIEW [dbo].[h4u_diagnosis]
AS
SELECT ltrim(o.hn) AS hn,
	o.regNo AS seq,
	convert(DATE, convert(CHAR, o.registDate - 5430000)) AS date_serve,
	m.ICDCode AS icd_code,
	i.DES AS icd_name,
	dx.DIAGTYPENAME AS diag_type,
	convert(TIME, left(o.timePt, 2) + ':' + right(o.timePt, 2)) AS time_serve
FROM OPD_H AS o(NOLOCK)
LEFT JOIN PATDIAG m(NOLOCK) ON o.hn = m.Hn
	AND o.regNo = m.regNo
	AND m.DiagType = 'I'
	AND dxtype = '1'
INNER JOIN ICD101 i(NOLOCK) ON m.ICDCode = i.CODE
INNER JOIN DIAGTYPE dx(NOLOCK) ON dx.DIAGTYPECODE = m.dxtype
