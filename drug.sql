CREATE VIEW [dbo].[h4u_drug]
AS
SELECT ltrim(o.hn) AS hn,
	o.regNo AS seq,
	convert(DATE, convert(CHAR, o.registDate - 5430000)) AS date_serve,
	convert(TIME, left(o.timePt, 2) + ':' + right(o.timePt, 2)) AS time_serve,
	i.name AS drug_name,
	m.accQty AS qty,
	rtrim(l2.lamed_name) AS unit,
	rtrim(l1.lamed_name) + ' ' + m.qtyPerFeed + rtrim(l2.lamed_name) + ' ' + m.lamedTimeText AS usage_line1,
	m.lamedText AS usage_line2,
	'' AS usage_line3
FROM OPD_H AS o(NOLOCK)
LEFT JOIN Patmed m(NOLOCK) ON o.hn = m.hn
	AND o.regNo = m.registNo
LEFT JOIN Med_inv i(NOLOCK) ON m.invCode = i.code
	AND site = '1'
	AND invType = 'M'
LEFT JOIN Lamed l1(NOLOCK) ON l1.lamed_code = m.lamedHow
LEFT JOIN Lamed l2(NOLOCK) ON l2.lamed_code = m.lamedUnit
WHERE m.accQty > 0
	AND m.invType = 'M'