CREATE VIEW [dbo].[h4u_procedure]
AS
SELECT ltrim(o.hn) AS hn,
	o.regNo AS seq,
	convert(DATE, convert(CHAR, o.registDate - 5430000)) AS date_serve,
	convert(TIME, left(o.timePt, 2) + ':' + right(o.timePt, 2)) AS time_serve,
	m.ICDCode AS procedure_code,
	i.DES AS procedure_name,
	'' AS start_date,
	'' AS start_time,
	'' AS end_date,
	'' AS end_time
FROM OPD_H AS o(NOLOCK)
LEFT JOIN PATDIAG m(NOLOCK) ON o.hn = m.Hn
	AND o.regNo = m.regNo
	AND m.DiagType = 'P'
INNER JOIN ICDCM1 i(NOLOCK) ON m.ICDCode = i.CODE
INNER JOIN DIAGTYPE dx(NOLOCK) ON dx.DIAGTYPECODE = m.dxtype