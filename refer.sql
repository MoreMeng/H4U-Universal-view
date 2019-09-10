CREATE VIEW [dbo].[h4u_refer]
AS
SELECT ltrim(o.hn) AS hn,
	o.regNo AS seq,
	convert(DATE, convert(CHAR, o.registDate - 5430000)) AS date_serve,
	convert(TIME, left(o.timePt, 2) + ':' + right(o.timePt, 2)) AS time_serve,
	b.REFEROUT AS hcode_to,
	b.REFEROUT AS name_to,
	b.TFReasonOut AS reason
FROM dbo.OPD_H(NOLOCK) AS o
INNER JOIN Bill_h(NOLOCK) AS b ON b.hn = o.hn
	AND b.regNo = o.regNo