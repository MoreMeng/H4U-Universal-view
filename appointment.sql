CREATE VIEW [dbo].[h4u_appointment]
AS
SELECT ltrim(o.hn) AS hn,
	o.regNo AS seq,
	convert(DATE, convert(CHAR, o.registDate - 5430000)) AS date_serve,
	convert(TIME, left(o.timePt, 2) + ':' + right(o.timePt, 2)) AS time_serve,
	RTRIM(CONVERT(CHAR, CONVERT(BIGINT, A.appoint_date) - 5430000)) AS date,
	convert(TIME, left(A.appoint_time_from, 2) + ':' + right(A.appoint_time_from, 2)) AS time,
	d.deptDesc AS department,
	A.appoint_note AS detail
FROM dbo.OPD_H(NOLOCK) AS o
INNER JOIN dbo.Appoint AS A(NOLOCK) ON A.hn = o.hn
	AND (
		A.appoint_regNo = o.regNo
		OR (convert(CHAR, convert(NUMERIC, convert(CHAR, keyin_time, 112)) + 5430000) = o.registDate)
		)
INNER JOIN DEPT d(NOLOCK) ON d.deptCode = A.pre_dept_code