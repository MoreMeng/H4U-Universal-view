CREATE VIEW [dbo].[h4u_lab]
AS
SELECT ltrim(o.hn) AS hn,
	o.regNo AS seq,
	convert(DATE, convert(CHAR, o.registDate - 5430000)) AS date_serve,
	convert(TIME, left(o.timePt, 2) + ':' + right(o.timePt, 2)) AS time_serve,
	d.lab_name + ' (' + rtrim(r.result_name) + ')' AS lab_name,
	r.real_res AS lab_result,
	CASE
		WHEN r.low_normal + '-' + r.high_normal = '999999.999-999999.999'
			THEN ''
		ELSE r.low_normal + '-' + r.high_normal
		END AS standard_result
FROM OPD_H AS o(NOLOCK)
LEFT JOIN Labreq_h h(NOLOCK) ON o.hn = h.hn
	AND o.regNo = h.reg_flag
INNER JOIN Labreq_d d(NOLOCK) ON h.req_no = d.req_no
INNER JOIN Labtype t(NOLOCK) ON d.lab_type = t.lab_type
INNER JOIN Labres_d r(NOLOCK) ON d.req_no = r.req_no
	AND d.lab_code = r.lab_code
WHERE h.res_ok = 'Y'