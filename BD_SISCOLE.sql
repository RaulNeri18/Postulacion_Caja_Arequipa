USE master
GO


DECLARE @DatabaseName nvarchar(50)
SET @DatabaseName = N'BD_SISCOLE'

DECLARE @SQL varchar(max)

SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + Convert(varchar, SPId) + ';'
FROM MASTER..SysProcesses
WHERE DBId = DB_ID(@DatabaseName) AND SPId <> @@SPId

--SELECT @SQL 
EXEC(@SQL)


IF DB_ID('BD_SISCOLE') IS NOT NULL
BEGIN
   DROP DATABASE BD_SISCOLE
END

CREATE DATABASE BD_SISCOLE
GO

USE BD_SISCOLE
GO

CREATE TABLE [dbo].[COLEGIO](
	[id_colegio] [int] IDENTITY(1,1) NOT NULL,
	[direccion] [varchar](200) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[id_pais] [int] NOT NULL,
 CONSTRAINT [PK_COLEGIO] PRIMARY KEY CLUSTERED 
(
	[id_colegio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[ALUMNO](
	[id_alumno] [int] IDENTITY(1,1) NOT NULL,
	[dni] [varchar](10) UNIQUE NOT NULL,
	[nombres] [varchar](100) NOT NULL,
	[apellidos] [varchar](100) NOT NULL,
	[fec_cumple] [datetime] NULL,
	[id_colegio] [int] NOT NULL,
 CONSTRAINT [PK_ALUMNO] PRIMARY KEY CLUSTERED 
(
	[id_alumno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[USUARIO](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[login] [varchar](20) NOT NULL,
	[password] [varchar](200) NOT NULL,
 CONSTRAINT [PK_USUARIO] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[ALUMNO]  WITH CHECK ADD  CONSTRAINT [FK_ALUMNO_COLEGIO] FOREIGN KEY([id_colegio])
REFERENCES [dbo].[COLEGIO] ([id_colegio])
GO

ALTER TABLE [dbo].[ALUMNO] CHECK CONSTRAINT [FK_ALUMNO_COLEGIO]
GO

INSERT INTO USUARIO
VALUES('raul.neri', '8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92')

INSERT INTO COLEGIO
VALUES('Calle Hildalgo 123', 'Colegio Benavides', 1),
	  ('Av. Pardo 321', 'Colegio Mariscal Caceres', 1)

INSERT INTO ALUMNO
VALUES('11111111','Carlos', 'Igreda', getdate(), 1),
	  ('22222222','Humberto', 'Peverell', getdate(), 2),
	  ('33333333','Jesus', 'Neyra', getdate(), 2),
	  ('44444444','Raul', 'Neri', getdate(), 2)


SELECT * FROM COLEGIO
SELECT * FROM ALUMNO
SELECT * FROM USUARIO