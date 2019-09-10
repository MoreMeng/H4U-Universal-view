CREATE VIEW [dbo].[h4u_service]
AS
SELECT ltrim(o.hn) AS hn,
	o.regNo AS seq,
	convert(DATE, convert(CHAR, o.registDate - 5430000)) AS date_serve,
	convert(TIME, left(o.timePt, 2) + ':' + right(o.timePt, 2)) AS time_serve
FROM OPD_H AS o(NOLOCK)