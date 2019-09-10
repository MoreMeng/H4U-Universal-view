CREATE VIEW [dbo].[h4u_vaccine]
AS
SELECT ltrim(o.hn) AS hn,
	convert(DATE, convert(CHAR, o.registDate - 5430000)) AS date_serve,
	convert(TIME, left(o.timePt, 2) + ':' + right(o.timePt, 2)) AS time_serve,
	V.VACCODE AS vaccine_code,
	V.VACNAME AS vaccine_name
FROM dbo.OPD_H AS o(NOLOCK)
LEFT JOIN Ipd_h I ON I.hn = o.hn
	AND I.regist_flag = o.regNo
LEFT JOIN dbo.Med_logh AS E(NOLOCK) ON E.hn = o.hn
	AND E.regNo = o.regNo
INNER JOIN dbo.Med_log AS EL(NOLOCK) ON E.batch_no = EL.batch_no
INNER JOIN dbo.PPOP_DRUG AS D(NOLOCK) ON D.INVCODE = EL.inv_code
	AND D.DTYPE = 'VC'
INNER JOIN dbo.PPOP_VACCINE AS V(NOLOCK) ON V.VACCODE = D.DRUGCODE
LEFT JOIN dbo.PPOP_CON AS ctl(NOLOCK) ON ctl.CON_KEY = '000'
LEFT JOIN PatSS P ON P.hn = o.hn