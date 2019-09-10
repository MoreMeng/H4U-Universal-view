CREATE VIEW [dbo].[h4u_profile]
AS
SELECT ltrim(p.hn) AS hn,
	RTRIM(s.CardID) AS cid,
	RTRIM(t.titleName) AS title_name,
	RTRIM(p.firstName) AS first_name,
	RTRIM(p.lastName) AS last_name
FROM dbo.PATIENT AS p(NOLOCK)
LEFT JOIN dbo.PatSS AS s(NOLOCK) ON p.hn = s.hn
LEFT JOIN dbo.PTITLE AS t(NOLOCK) ON t.titleCode = p.titleCode