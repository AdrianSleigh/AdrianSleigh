USE [master]
GO
/****** Object:  Database [SQL_Monitoring]    Script Date: 3/9/2023 12:06:48 PM ******/
CREATE DATABASE [SQL_Monitoring]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SQL_Monitoring', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL15.DEVELOPMENT\MSSQL\DATA\SQL_Monitoring.mdf' , SIZE = 819200KB , MAXSIZE = UNLIMITED, FILEGROWTH = 102400KB )
 LOG ON 
( NAME = N'SQL_Monitoring_log', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL15.DEVELOPMENT\MSSQL\DATA\SQL_Monitoring_log.ldf' , SIZE = 1739904KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SQL_Monitoring] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SQL_Monitoring].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SQL_Monitoring] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET ARITHABORT OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SQL_Monitoring] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SQL_Monitoring] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SQL_Monitoring] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SQL_Monitoring] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET RECOVERY FULL 
GO
ALTER DATABASE [SQL_Monitoring] SET  MULTI_USER 
GO
ALTER DATABASE [SQL_Monitoring] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SQL_Monitoring] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SQL_Monitoring] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SQL_Monitoring] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SQL_Monitoring] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SQL_Monitoring] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SQL_Monitoring] SET QUERY_STORE = OFF
GO
USE [SQL_Monitoring]
GO
/****** Object:  User [SANDLNK\svc_AGTDS-3Server-De]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE USER [SANDLNK\svc_AGTDS-3Server-De] FOR LOGIN [SANDLNK\svc_AGTDS-3Server-De] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [SANDLNK\svc_AGTDS-2Server-De]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE USER [SANDLNK\svc_AGTDS-2Server-De] FOR LOGIN [SANDLNK\svc_AGTDS-2Server-De] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [SANDLNK\SQL-DBT-ADM]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE USER [SANDLNK\SQL-DBT-ADM] FOR LOGIN [SANDLNK\SQL-DBT-ADM]
GO
/****** Object:  User [sandlnk\brh3502020]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE USER [sandlnk\brh3502020] FOR LOGIN [SANDLNK\BRH3502020] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Link_SVR]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE USER [Link_SVR] FOR LOGIN [Link_SVR] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [SANDLNK\svc_AGTDS-3Server-De]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [SANDLNK\svc_AGTDS-3Server-De]
GO
ALTER ROLE [db_owner] ADD MEMBER [SANDLNK\svc_AGTDS-2Server-De]
GO
ALTER ROLE [db_owner] ADD MEMBER [SANDLNK\SQL-DBT-ADM]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Link_SVR]
GO
/****** Object:  Table [dbo].[BACKUPS]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BACKUPS](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_Date] [smalldatetime] NULL,
	[HA_Primary] [sql_variant] NULL,
	[Database_Name] [nchar](60) NOT NULL,
	[DaysSinceLastBackup] [smallint] NOT NULL,
	[LastBackupDate] [smalldatetime] NOT NULL,
	[BackupType] [nchar](1) NOT NULL,
 CONSTRAINT [PK_LAST_BACKUP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BLOCKING]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BLOCKING](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_Date] [datetime] NOT NULL,
	[Spid] [int] NOT NULL,
	[Blocked] [int] NOT NULL,
	[LeadBlocker] [int] NOT NULL,
	[BObject] [nvarchar](50) NOT NULL,
	[WaitTime] [int] NOT NULL,
	[LastWaitType] [nchar](20) NOT NULL,
	[PhysicalIO] [int] NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[LastBatch] [datetime] NOT NULL,
	[OpenTran] [int] NOT NULL,
	[BStatus] [nchar](50) NOT NULL,
	[Hostname] [nchar](50) NOT NULL,
	[ProgramName] [nchar](100) NOT NULL,
	[LoginName] [nchar](50) NOT NULL,
 CONSTRAINT [PK_BLOCKING] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONNECTION_MONITOR]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONNECTION_MONITOR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Ran_date] [smalldatetime] NULL,
	[Instance] [nchar](120) NULL,
	[LoginName] [nvarchar](100) NULL,
	[Host] [nvarchar](20) NULL,
	[ProgName] [nvarchar](100) NULL,
	[DbName] [nvarchar](150) NULL,
	[Connections] [int] NULL,
	[EarliestLogin] [datetime] NULL,
	[LatestLogin] [datetime] NULL,
	[Status] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CPU_DETAILS]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CPU_DETAILS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_date] [smalldatetime] NOT NULL,
	[object_name] [nchar](100) NULL,
	[text_data] [ntext] NOT NULL,
	[disk_reads] [int] NOT NULL,
	[memory_reads] [int] NOT NULL,
	[executions] [int] NOT NULL,
	[total_cpu_time] [int] NOT NULL,
	[average_cpu_time] [int] NOT NULL,
	[disk_wait_and_cpu_time] [bigint] NOT NULL,
	[memory_writes] [int] NOT NULL,
	[date_cached] [smalldatetime] NOT NULL,
	[database_name] [nchar](100) NULL,
	[last_execution] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_CPU_DETAILS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CPU_USAGE]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CPU_USAGE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SQL_CPU_Utilisation] [int] NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[System_Idle] [int] NOT NULL,
	[Other_CPU_Utilisation] [int] NOT NULL,
	[Ran_Date] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_CPU_USAGE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_ACTIVITY]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_ACTIVITY](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_date] [smalldatetime] NOT NULL,
	[TotalPageReads] [int] NOT NULL,
	[TotalPageWrites] [int] NOT NULL,
	[Databasename] [nchar](60) NOT NULL,
 CONSTRAINT [PK_DB_ACTIVITY] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_GROWTH]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_GROWTH](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_Date] [date] NULL,
	[DatabaseName] [nvarchar](200) NOT NULL,
	[YearMonth] [int] NOT NULL,
	[MinSize] [decimal](18, 2) NULL,
	[MaxSize] [decimal](18, 2) NULL,
	[AvgSize] [decimal](18, 2) NULL,
	[Growth] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_GROWTH_12]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_GROWTH_12](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_Date] [date] NULL,
	[DatabaseName] [nchar](100) NOT NULL,
	[0] [numeric](18, 0) NULL,
	[-1] [numeric](18, 0) NULL,
	[-2] [numeric](18, 0) NULL,
	[-3] [numeric](18, 0) NULL,
	[-4] [numeric](18, 0) NULL,
	[-5] [numeric](18, 0) NULL,
	[-6] [numeric](18, 0) NULL,
	[-7] [numeric](18, 0) NULL,
	[-8] [numeric](18, 0) NULL,
	[-9] [numeric](18, 0) NULL,
	[-10] [numeric](18, 0) NULL,
	[-11] [numeric](18, 0) NULL,
	[-12] [numeric](18, 0) NULL,
 CONSTRAINT [PK_DB_GROWTH_12] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_SIZES]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_SIZES](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_Date] [smalldatetime] NOT NULL,
	[Db_Name] [nchar](60) NOT NULL,
	[Db_Status] [nchar](10) NOT NULL,
	[Recovery_Model] [nchar](10) NOT NULL,
	[Db_Size] [decimal](18, 0) NOT NULL,
	[File_Size_MB] [decimal](18, 0) NOT NULL,
	[Space_Used_MB] [decimal](18, 0) NOT NULL,
	[Free_Space_MB] [decimal](18, 0) NOT NULL,
	[Log_File_MB] [decimal](18, 0) NOT NULL,
	[Log_Space_Used_MB] [decimal](18, 0) NOT NULL,
	[Log_Free_Space_MB] [decimal](18, 0) NOT NULL,
	[Db_Freespace] [nchar](20) NOT NULL,
 CONSTRAINT [PK_DB_SIZES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DRIVE_SPACE_FREE]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DRIVE_SPACE_FREE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_Date] [smalldatetime] NOT NULL,
	[Drive] [nchar](10) NOT NULL,
	[Total_Space_GB] [decimal](18, 0) NOT NULL,
	[Free_Space_GB] [decimal](18, 0) NOT NULL,
	[Percent_Free_GB] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_DRIVE_SPACE_FREE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAILED_LOGINS]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAILED_LOGINS](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Ran_date] [smalldatetime] NULL,
	[Instance] [nchar](120) NOT NULL,
	[NumberOfAttempts] [smallint] NOT NULL,
	[Details] [ntext] NOT NULL,
	[MinLogDate] [smalldatetime] NOT NULL,
	[MaxLogDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_FAILED_LOGINS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FRAGMENTATION]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FRAGMENTATION](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_Date] [smalldatetime] NOT NULL,
	[Databasename] [nchar](100) NOT NULL,
	[Tablename] [nchar](100) NOT NULL,
	[Indexname] [nchar](100) NOT NULL,
	[Fragpercent] [decimal](18, 0) NOT NULL,
	[IndexType] [nchar](20) NOT NULL,
	[Page_count] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JOB_FAILS]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JOB_FAILS](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_date] [smalldatetime] NOT NULL,
	[Job_name] [nchar](100) NOT NULL,
	[Job_step] [smallint] NOT NULL,
	[Error_message] [ntext] NULL,
 CONSTRAINT [PK_JOB_FAILS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LAST_USED_DB]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LAST_USED_DB](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Ran_date] [smalldatetime] NULL,
	[Instance] [nchar](120) NULL,
	[Last_Restart] [datetime] NULL,
	[DbName] [nvarchar](50) NULL,
	[Last_User_Seek] [datetime] NULL,
	[Last_User_Scan] [datetime] NULL,
	[Last_User_Lookup] [datetime] NULL,
	[Last_User_Update] [datetime] NULL,
 CONSTRAINT [PK_LAST_USED_DB] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGINS_ISSUE]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOGINS_ISSUE](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[ran_date] [smalldatetime] NOT NULL,
	[primary_instance] [nchar](50) NULL,
	[secondary_instance] [nchar](50) NULL,
 CONSTRAINT [PK_LOGINS_ISSUE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_VERSION]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_VERSION](
	[Vid] [smallint] IDENTITY(1,1) NOT NULL,
	[dbInstance] [nchar](120) NULL,
	[dbVersion] [decimal](9, 2) NULL,
	[dbDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEMORY_USAGE]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEMORY_USAGE](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_date] [smalldatetime] NOT NULL,
	[DbName] [nchar](50) NOT NULL,
	[DB_buffer_pages] [int] NOT NULL,
	[DB_buffer_MB] [smallint] NOT NULL,
	[DB_buffer_percent] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_MEMORY_USAGE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PLE]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLE](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_date] [smalldatetime] NOT NULL,
	[Countername] [nchar](25) NOT NULL,
	[PagelifeValue] [int] NOT NULL,
 CONSTRAINT [PK_PLE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WORST_QUERIES]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WORST_QUERIES](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[database_name] [nchar](60) NOT NULL,
	[Instance] [nchar](120) NOT NULL,
	[Ran_date] [smalldatetime] NOT NULL,
	[object_name] [nchar](60) NOT NULL,
	[max_logical_reads] [int] NOT NULL,
	[max_logical_writes] [int] NOT NULL,
	[total_RW] [int] NOT NULL,
	[max_elapsed_time_MS] [int] NOT NULL,
	[execution_cost] [int] NOT NULL,
	[last_execution_time] [smalldatetime] NOT NULL,
	[execution_count] [int] NOT NULL,
	[object_text] [text] NOT NULL,
 CONSTRAINT [PK_WORST_QUERIES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20230215-134443]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20230215-134443] ON [dbo].[DB_GROWTH_12]
(
	[DatabaseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-LULO]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-LULO] ON [dbo].[LAST_USED_DB]
(
	[Last_User_Lookup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-LUSC]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-LUSC] ON [dbo].[LAST_USED_DB]
(
	[Last_User_Scan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-LUSE]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-LUSE] ON [dbo].[LAST_USED_DB]
(
	[Last_User_Seek] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-LUUP]    Script Date: 3/9/2023 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-LUUP] ON [dbo].[LAST_USED_DB]
(
	[Last_User_Update] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_alert_backup]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_alert_backup]

AS

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/03/16 V2.0
-- Item:	usp_alert_backup sends email alert on issues
-- Description Part of suite of scripts for monitoring
-- =============================================

SELECT getdate()AS run_date,
SUBSTRING(B.name,1,30) AS Database_Name, ISNULL(STR(ABS(DATEDIFF(day, GetDate(), 
                MAX(Backup_finish_date)))), 'NEVER') AS DaysSinceLastBackup,
                ISNULL(Convert(char(10), MAX(backup_finish_date), 101), 'NEVER') AS LastBackupDate,
				A.type AS 'TYPE'
 INTO ##LastBackup 
                FROM MASTER.dbo.sysdatabases B LEFT OUTER JOIN MSDB.dbo.backupset A 
                ON A.database_name = B.name 
				AND A.type = 'D' 
				OR A.type = 'I'  
				OR A.type = 'L'
                WHERE B.name NOT IN ('Tempdb','model')

                GROUP BY B.name, A.type
				ORDER BY B.name

               -----------Return values
			/*	SELECT * FROM ##LastBackup
				WHERE DaysSinceLastBackup >6 AND TYPE = 'D'
				OR    DaysSinceLastBackup >1 AND TYPE = 'I'
				OR    DaysSinceLastBackup >1 AND TYPE = 'L'
			*/	
  ----------------------------------------------------------------------------------------
  	IF NOT EXISTS ( select 1 from ##LastBackup )
BEGIN
 PRINT 'empty table... '  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body = 'SQL Missing Backup Issue',
    @query = 'SET NOCOUNT ON PRINT ''Missing Backups on SLKBRHSQLDSCN02\DEVELOPMENT''
          SELECT * FROM ##LastBackup
				WHERE DaysSinceLastBackup >=6 AND TYPE = ''D''
				OR    DaysSinceLastBackup >=1 AND TYPE = ''I''
				OR    DaysSinceLastBackup >=1 AND TYPE = ''L'' ',
    
	@subject = 'ALERTS- SLKBRHSQLDSCN02\DEVELOPMENT MISSING BACKUP ISSUES' ,
	@attach_query_result_as_file = 1,
	@query_attachment_filename = 'MissingBackupIssue.txt';  
PRINT 'Missing Backup Issue '
------------------------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[usp_alert_drvspace]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/03/21 V1.0
-- Item:	usp_alert_drvspace alerts space less than 20% free. Run job every 15 mins
-- Description Part of suite of scripts for monitoring
-- =============================================
CREATE PROCEDURE [dbo].[usp_alert_drvspace]
AS
	IF OBJECT_ID(N'tempdb..##drvspace') IS NOT NULL
BEGIN
DROP TABLE ##drvspace
END

CREATE TABLE ##drvspace(ran_date smalldatetime ,drive varchar(4), totalspacegb float, freespacegb float, pctfree float )
INSERT INTO ##drvspace

SELECT  getdate() AS Ran_Date
    ,   Drive
    ,   TotalSpaceGB
    ,   FreeSpaceGB
    ,   PctFree
  FROM
    (SELECT DISTINCT
        SUBSTRING(dovs.volume_mount_point, 1, 10) AS Drive
    ,   CONVERT(INT, dovs.total_bytes / 1024.0 / 1024.0 / 1024.0) AS TotalSpaceGB
    ,   CONVERT(INT, dovs.available_bytes / 1048576.0) / 1024 AS FreeSpaceGB
    ,   CAST(ROUND(( CONVERT(FLOAT, dovs.available_bytes / 1048576.0) / CONVERT(FLOAT, dovs.total_bytes / 1024.0 /
                         1024.0) * 100 ), 2) AS NVARCHAR(50)) AS PctFree
    FROM    sys.master_files AS mf
    CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.file_id) AS dovs) AS DE

  --	SELECT * FROM ##drvspace WHERE pctfree <=20

	IF NOT EXISTS ( SELECT 1 FROM ##drvspace WHERE pctfree <=20 )
BEGIN
 PRINT 'Empty table... no drive space issues '  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body  = 'Drive Space alert in the last 15 mins......Space less than 20% free',
    @query = 'SET NOCOUNT ON PRINT ''Recent drive space alert''
         SELECT * FROM ##drvspace WHERE pctfree <=20 AND ran_date > dateadd(mi,-15,Getdate()) ',
    @subject = 'ALERTS- SLKBRHSQLDSCN02\DEVELOPMENT RECENT DRIVE SPACE ALERT LESS THAN 20% FREE', 
	@attach_query_result_as_file = 1,
	@query_attachment_filename = 'RecentDriveSpaceAlert.txt'; 
PRINT 'Recent Drive Space Alert'
GO
/****** Object:  StoredProcedure [dbo].[usp_alert_jobfail]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_alert_jobfail]
AS
-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/03/20 V1.0
-- Item:	usp_alert_jobfail alert run every 15 mins
-- Description Part of suite of scripts for monitoring
-- =============================================

IF NOT EXISTS( SELECT 1 FROM msdb.dbo.sysjobs AS j
    INNER JOIN msdb.dbo.sysjobsteps AS js ON js.job_id = j.job_id
    INNER JOIN msdb.dbo.sysjobhistory AS jh ON jh.job_id = j.job_id AND jh.step_id = js.step_id
    WHERE jh.run_status = 0 
    AND MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) > dateadd(mi,-16,Getdate())
	)
	BEGIN
 PRINT 'empty table... no job fails'  
END
ELSE

BEGIN
 EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body = 'A FAILED AGENT JOB OCCURRED',
    @query = 'SET NOCOUNT ON PRINT ''FAILED AGENT JOB OCCURRED''
    SELECT  MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) AS job_ran_time,
    SUBSTRING(j.name,1,50) AS job_name,
	js.step_id AS job_step,
	SUBSTRING(jh.message,1,180) AS error_message
     FROM msdb.dbo.sysjobs AS j
      INNER JOIN msdb.dbo.sysjobsteps AS js ON js.job_id = j.job_id
      INNER JOIN msdb.dbo.sysjobhistory AS jh ON jh.job_id = j.job_id AND jh.step_id = js.step_id
         WHERE jh.run_status = 0 
       AND MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) > dateadd(mi,-15,Getdate())',
    @subject = 'ALERTS - SLKBRHSQLDSCN02\DEVELOPMENT FAILED AGENT JOB OCCURRED' ,
	@attach_query_result_as_file = 1,
	@query_attachment_filename = 'FAILED_AGENT_JOB_OCCURRED.txt';  
PRINT 'FAILED AGENT JOB OCCURRED'
END

GO
/****** Object:  StoredProcedure [dbo].[usp_alert_loginfail]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/03/21 V1.0
-- Item:	usp_alert_loginfail alert run every 15 mins
-- Description Part of suite of scripts for monitoring
-- =============================================
CREATE PROCEDURE [dbo].[usp_alert_loginfail]
AS

IF OBJECT_ID(N'tempdb..##LoginFail') IS NOT NULL
BEGIN
DROP TABLE ##LoginFail
END

CREATE TABLE ##LoginFail(logdate smalldatetime ,processInfo varchar(10), TextDesc Text)
INSERT INTO ##LoginFail
 EXEC sp_readerrorlog 0, 1, 'Login failed' 

IF NOT EXISTS ( select 1 from ##LoginFail )
BEGIN
 PRINT 'empty table... no failed logins'  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body  = 'Failed logins in the last 15 mins on SLKBRHSQLDSCN02\DEVELOPMENT',
    @query = 'SET NOCOUNT ON PRINT ''Recent Failed Logins''
       SELECT * FROM ##LoginFail WHERE logdate > dateadd(mi,-15,Getdate())',
    @subject = 'ALERTS- SLKBRHSQLDSCN02\DEVELOPMENT RECENT LOGIN FAILS', 
	@attach_query_result_as_file = 1,
	@query_attachment_filename = 'RecentLoginFails.txt'; 
PRINT 'Recent Login fails present'
GO
/****** Object:  StoredProcedure [dbo].[usp_blocking]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/01 V4.0
-- Added email alerting triggered if blocking occurs - time limit 10 mins
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Item:	usp_Blocking
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_blocking]
AS
BEGIN
INSERT INTO BLOCKING (Instance,Ran_Date,Spid,Blocked,LeadBlocker,BObject,WaitTime,LastWaitType,PhysicalIO,LoginTime,LastBatch,OpenTran,BStatus,Hostname,ProgramName,LoginName)
SELECT  @@servername,
    getdate() AS 'Ran_Date' 
  , p.spid
  , p.blocked
  , ISNULL(l.spid, 0) AS 'LeadBlocker'
  , d.name
  , p.waittime
  , p.lastwaittype
  , p.physical_io
  , p.login_time
  , p.last_batch
  , p.open_tran
  , p.status
  , p.hostname
  , p.program_name
  , p.loginame
 
FROM sysprocesses p
 INNER JOIN sysdatabases d
  ON p.dbid = d.dbid
 LEFT OUTER JOIN (SELECT spid 
      FROM  master..sysprocesses a
         WHERE  exists ( SELECT b.*
                FROM master..sysprocesses b
                WHERE b.blocked > 0 
          AND b.blocked = a.spid ) 
           AND NOT
           EXISTS ( SELECT b.*
              FROM master..sysprocesses b
              WHERE b.blocked > 0 
              AND b.spid = a.spid )) l
     ON p.spid = l.spid
WHERE p.spid > 50
AND p.blocked <> 0
OR  l.spid <> 0
END
----------------------------------------------------------------
 IF NOT EXISTS ( SELECT 1 FROM[SQL_Monitoring].[dbo].[BLOCKING] WHERE ran_date > dateadd(mi,-10,Getdate()) )
  BEGIN
  PRINT 'empty table... no issues'  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com',  
    @body = 'There was a blocking issue',
    @query = 'SET NOCOUNT ON PRINT ''Blocking detected''
SELECT [Ran_Date],[Spid],[Blocked],[LeadBlocker],
SUBSTRING([BObject],1,20)AS Object,[WaitTime],
[LastWaitType],[PhysicalIO],[LoginTime],[LastBatch],[OpenTran],
SUBSTRING([BStatus],1,20)AS Status,
SUBSTRING([Hostname],1,30) AS Hostname,
SUBSTRING([ProgramName],1,40)AS ProgramName ,
SUBSTRING([LoginName],1,40)AS LoginName
FROM[SQL_Monitoring].[dbo].[BLOCKING]

-------SENDS EMAIL IF BLOCKING LESS THAN 10 MINS OLD
WHERE ran_date > dateadd(mi,-10,Getdate())',
    @subject = 'ALERTS- SLKBRHSQLDSCN02\DEVELOPMENT-BLOCKING DETECTED' ,
	@attach_query_result_as_file = 1 , 
	@query_attachment_filename = 'Blocking_detected.txt';
PRINT 'Blocking detected'


SELECT * FROM[SQL_Monitoring].[dbo].[BLOCKING] WHERE ran_date > dateadd(mi,-10,Getdate())
GO
/****** Object:  StoredProcedure [dbo].[usp_connection_monitor]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/08 V3.0
-- Item:	Connection Monitor
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_connection_monitor] 
	
AS
BEGIN
	
	SET NOCOUNT ON;

-- Create the data table if its not already there
	IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Connection_Monitor') and OBJECTPROPERTY(id, N'IsTable') = 1)
	BEGIN
		CREATE TABLE dbo.CONNECTION_MONITOR
		(
			[ID] [int]		IDENTITY(1,1) NOT NULL,
			Ran_date		SMALLDATETIME,
			Instance        NVARCHAR(120),
			LoginName		NVARCHAR(100),
			Host			NVARCHAR(100),
			ProgName		NVARCHAR(100),
			DbName			NVARCHAR(150),
			Connections		INT,
			EarliestLogin	DATETIME,
			LatestLogin		DATETIME,
			[Status]		NVARCHAR(100)
		)
	END

-- Create a temporary store for extract
	IF OBJECT_ID('tempdb..#tabConnMon') IS NULL
	BEGIN
		CREATE TABLE #tabConnMon
		(
			[ID] [int]		IDENTITY(1,1) NOT NULL,
			Ran_date		SMALLDATETIME,
			Instance        NVARCHAR(120),
			LoginName		NVARCHAR(100),
			Host			NVARCHAR(100),
			ProgName		NVARCHAR(100),
			DbName			NVARCHAR(50),
			Connections		INT,
			EarliestLogin	DATETIME,
			LatestLogin		DATETIME,
			[Status]		NVARCHAR(100)
		)
	END

-- Extract from system tables to temp table grouping by user, host, prog
	BEGIN
		INSERT INTO
			#tabConnMon
		(
            Ran_date,
	    	Instance,
			LoginName,
			Host,
			ProgName,
			DbName,
			Connections,
			EarliestLogin,
			LatestLogin,
			[Status]
		)
		SELECT
            getdate () as Date_ran,
	    	@@servername as Instance,			
			LEFT(ISNULL(A.loginame, ''), 100) AS LoginName,
			LEFT(ISNULL(A.hostname, ''), 100) AS Host,
			LEFT(ISNULL(B.program_name, ''), 100),
			DB_NAME(LEFT(ISNULL(A.dbid, ''), 50)) AS DBName, 
			COUNT(A.dbid) AS NumberOfConnections,
			MIN(A.login_time) AS EarliestLogin,
			MAX(A.login_time) AS LatestLogin,
			LEFT(A.status, 100) AS Status
		FROM
			sys.sysprocesses AS A
		LEFT OUTER JOIN
            sys.dm_exec_sessions AS B
		ON
			A.spid = B.session_id
		WHERE 
			A.dbid > 4
		GROUP BY 

			A.dbid, A.hostname, B.program_name, A.loginame, A.status
	END

-- Save results to data table without duplicating Login, Host, Prog and DbName
	BEGIN
		INSERT INTO
			dbo.Connection_Monitor
		(
            Ran_date,
			Instance,
			LoginName,
			Host,
			ProgName,
			DbName,
			Connections,
			EarliestLogin,
			LatestLogin,
			[Status]
		)
		SELECT
	     	#tabConnMon.Ran_date,
			#tabConnMon.Instance,
			#tabConnMon.LoginName,
			#tabConnMon.Host,
			#tabConnMon.ProgName,
			#tabConnMon.DbName,
			#tabConnMon.Connections,
			#tabConnMon.EarliestLogin,
			#tabConnMon.LatestLogin,
			#tabConnMon.[Status]
		FROM
			#tabConnMon
		LEFT OUTER JOIN
            Connection_Monitor
		ON
			#tabConnMon.LoginName = dbo.Connection_Monitor.LoginName
		AND
			#tabConnMon.Host = dbo.Connection_Monitor.Host
		AND 
			#tabConnMon.ProgName = dbo.Connection_Monitor.ProgName
		AND
			#tabConnMon.DbName = dbo.Connection_Monitor.DbName
		WHERE
			(dbo.Connection_Monitor.ID IS NULL)
	END

 -- Update latest login and status where login, host, prog and db are the same
	BEGIN
		UPDATE
			dbo.Connection_Monitor
		SET
			dbo.Connection_Monitor.LatestLogin = dbo.#tabConnMon.LatestLogin,
			dbo.Connection_Monitor.Status = dbo.#tabConnMon.Status
		FROM
			dbo.Connection_Monitor
		INNER JOIN
			dbo.#tabConnMon
		ON
			dbo.Connection_Monitor.LoginName = dbo.#tabConnMon.LoginName
		AND
			dbo.Connection_Monitor.Host = dbo.#tabConnMon.Host
		AND 
			dbo.Connection_Monitor.ProgName = dbo.#tabConnMon.ProgName
		AND 
			dbo.Connection_Monitor.DbName = dbo.#tabConnMon.DbName
	END

--SELECT * FROM dbo.Connection_Monitor

-- Remove temp table
	BEGIN
		IF OBJECT_ID('tempdb..#tabConnMon') IS NOT NULL DROP TABLE #tabConnMon
	END
END
GO
/****** Object:  StoredProcedure [dbo].[usp_cpu_details]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_cpu_details]

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/01 V2.0
-- Item:	usp_cpu_details
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================
AS
INSERT INTO [SQL_Monitoring].[dbo].[CPU_DETAILS]
([Instance],[Ran_date],[object_name],[text_data],[disk_reads],[memory_reads],[executions],
[total_cpu_time],[average_cpu_time],[disk_wait_and_cpu_time],[memory_writes],[date_cached],
[database_name],[last_execution]
)

SELECT TOP 20
   @@servername as Instance,
   getdate() as Ran_date,
    ObjectName          = OBJECT_SCHEMA_NAME(qt.objectid,dbid) + '.' + OBJECT_NAME(qt.objectid, qt.dbid)
    ,TextData           = qt.text
    ,DiskReads          = qs.total_physical_reads   -- The worst reads, disk reads
    ,MemoryReads        = qs.total_logical_reads    --Logical Reads are memory reads
    ,Executions         = qs.execution_count
    ,TotalCPUTime       = qs.total_worker_time
    ,AverageCPUTime     = qs.total_worker_time/qs.execution_count
    ,DiskWaitAndCPUTime = qs.total_elapsed_time
    ,MemoryWrites       = qs.max_logical_writes
    ,DateCached         = qs.creation_time
    ,DatabaseName       = DB_Name(qt.dbid)
    ,LastExecutionTime  = qs.last_execution_time
 FROM sys.dm_exec_query_stats AS qs
 CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
-- ORDER BY qs.total_worker_time DESC

GO
/****** Object:  StoredProcedure [dbo].[usp_db_activity]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/01 V2.0
-- Item:	usp_db_activity
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================
CREATE PROCEDURE [dbo].[usp_db_activity]

AS

INSERT INTO SQL_Monitoring.dbo.DB_ACTIVITY (Instance,Ran_date,TotalPageReads,TotalPageWrites,Databasename)

SELECT 
@@servername as Instance,
Getdate() AS Ran_date,
SUM(deqs.total_logical_reads) TotalPageReads,
SUM(deqs.total_logical_writes) TotalPageWrites, 
CASE
WHEN DB_NAME(dest.dbid) IS NULL THEN 'AdhocSQL'
ELSE DB_NAME(dest.dbid) END Databasename
FROM sys.dm_exec_query_stats deqs
CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest
GROUP BY DB_NAME(dest.dbid)
GO
/****** Object:  StoredProcedure [dbo].[usp_db_growth]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/01 V3.Growth  SQL_Monitoring
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_db_growth]
AS
DECLARE @endDate datetime, @months smallint; 
SET     @endDate = GetDate();  -- Date actual
SET     @months = 12;          -- months
;
WITH HIST AS 
   (SELECT  BS.database_name AS DatabaseName 
          ,YEAR(BS.backup_start_date) * 100 
           + MONTH(BS.backup_start_date) AS YearMonth 
          ,CONVERT(numeric(10, 1), MIN(BS.backup_size / 1048576.0)) AS MinSizeMB 
          ,CONVERT(numeric(10, 1), MAX(BS.backup_size / 1048576.0)) AS MaxSizeMB 
          ,CONVERT(numeric(10, 1), AVG(BS.backup_size / 1048576.0)) AS AvgSizeMB 
    FROM msdb.dbo.backupset as BS 
    WHERE NOT BS.database_name IN 
              ('Master', 'Msdb', 'Model', 'Tempdb','SQLMonitoring') 
          AND BS.type = 'D' 
         -- AND BS.backup_start_date BETWEEN DATEADD(mm, - @months, @endDate) AND     @endDate 
    GROUP BY BS.database_name 
            ,YEAR(BS.backup_start_date) 
            ,MONTH(BS.backup_start_date)) 
SELECT CONVERT (Date, GETDATE())AS Ran_date
      ,@@servername AS Instance
      ,MAIN.DatabaseName 
      ,MAIN.YearMonth 
      ,MAIN.MinSizeMB 
      ,MAIN.MaxSizeMB 
      ,MAIN.AvgSizeMB 
      ,MAIN.AvgSizeMB  
       - (SELECT TOP 1 SUB.AvgSizeMB 
          FROM HIST AS SUB 
          WHERE SUB.DatabaseName = MAIN.DatabaseName 
                AND SUB.YearMonth < MAIN.YearMonth 
          ORDER BY SUB.YearMonth DESC) AS GrowthMB 
FROM HIST AS MAIN 


ORDER BY MAIN.DatabaseName 
        ,MAIN.YearMonth
DECLARE @startDate DATETIME;
GO
/****** Object:  StoredProcedure [dbo].[usp_db_growth_12]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/01 V3.Growth 12 months SQL_Monitoring
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_db_growth_12]

AS
DECLARE 
@endDate datetime = GetDate(),
@startDate datetime = GetDate()-12,
@instance Varchar (120)= @@servername,
@months smallint = 12;

; WITH HIST AS 
   (SELECT BS.database_name AS DatabaseName 
          ,YEAR(BS.backup_start_date) * 100 
           + MONTH(BS.backup_start_date) AS YearMonth 
          ,CONVERT(numeric(10, 1), MIN(BS.backup_size / 1048576.0)) AS MinSizeMB 
          ,CONVERT(numeric(10, 1), MAX(BS.backup_size / 1048576.0)) AS MaxSizeMB 
          ,CONVERT(numeric(10, 1), AVG(BS.backup_size / 1048576.0)) AS AvgSizeMB 
    FROM msdb.dbo.backupset as BS 
    WHERE NOT BS.database_name IN 
              ('Master', 'Msdb', 'Model', 'Tempdb','SQLMonitoring') 
          AND BS.type = 'D' 
          AND BS.backup_start_date BETWEEN DATEADD(mm, - @months, @endDate) AND  @endDate 
    GROUP BY BS.database_name 
            ,YEAR(BS.backup_start_date) 
            ,MONTH(BS.backup_start_date)
			) 
SELECT  CONVERT (Date, GETDATE())AS RanDate,@instance AS Instance,PVT.DatabaseName
    ,PVT.[0],PVT.[-1],PVT.[-2],PVT.[-3],PVT.[-4],PVT.[-5],PVT.[-6],PVT.[-7],PVT.[-8],PVT.[-9],PVT.[-10],PVT.[-11],PVT.[-12]
FROM (
    SELECT BS.database_name AS DatabaseName
        ,DATEDIFF(mm, @startDate, BS.backup_start_date) AS MonthsAgo
        ,CONVERT(NUMERIC(10, 1), AVG(BF.file_size / 1048576.0)) AS AvgSizeMB
    FROM msdb.dbo.backupset AS BS
    INNER JOIN msdb.dbo.backupfile AS BF ON BS.backup_set_id = BF.backup_set_id
    WHERE BS.database_name NOT IN ('Master','Msdb','Model','Tempdb','SQL_Monitoring')
        AND BS.database_name IN (
            SELECT db_name(database_id)
            FROM master.SYS.DATABASES
            WHERE state_desc = 'ONLINE'
            )
        AND BF.[file_type] = 'D'
        AND BS.backup_start_date BETWEEN DATEADD(yy, - 1, @startDate)
            AND @startDate
    GROUP BY BS.database_name
        ,DATEDIFF(mm, @startDate, BS.backup_start_date)
    ) AS BCKSTAT

PIVOT(SUM(BCKSTAT.AvgSizeMB) FOR BCKSTAT.MonthsAgo	IN (
            [0],[-1],[-2],[-3],[-4],[-5],[-6],[-7],[-8],[-9],[-10],[-11],[-12]
            )) AS PVT
ORDER BY PVT.DatabaseName;


-------------------------------------------------------

GO
/****** Object:  StoredProcedure [dbo].[usp_db_sizes]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/05 V2.0
-- Item:	db_sizes
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================



CREATE PROCEDURE  [dbo].[usp_db_sizes]

AS
--USE [SQL_Monitoring]

--if exists (select * from tempdb.sys.all_objects where name like '%#dbsize%')
--drop table #dbsize
create table #dbsize
(Dbname varchar(300),dbstatus varchar(200),Recovery_Model varchar(100) default ('NA'), file_Size_MB decimal(20,2)default (0),Space_Used_MB decimal(20,2)default (0),Free_Space_MB decimal(20,2) default (0))
 
insert into #dbsize(Dbname,dbstatus,Recovery_Model,file_Size_MB,Space_Used_MB,Free_Space_MB)
exec sp_msforeachdb
'use [?];
  select DB_NAME() AS DbName,
    CONVERT(varchar(20),DatabasePropertyEx(''?'',''Status'')) , 
    CONVERT(varchar(20),DatabasePropertyEx(''?'',''Recovery'')), 
sum(size)/128.0 AS File_Size_MB,
sum(CAST(FILEPROPERTY(name, ''SpaceUsed'') AS INT))/128.0 as Space_Used_MB,
SUM( size)/128.0 - sum(CAST(FILEPROPERTY(name,''SpaceUsed'') AS INT))/128.0 AS Free_Space_MB 
from sys.database_files  where type=0 group by type'
 
  -------------------log size--------------------------------------
  if exists (select * from tempdb.sys.all_objects where name like '#logsize%')
drop table #logsize
create table #logsize
(Dbname varchar(300), Log_File_Size_MB decimal(20,2)default (0),log_Space_Used_MB decimal(20,2)default (0),log_Free_Space_MB decimal(20,2)default (0))

 insert into #logsize(Dbname,Log_File_Size_MB,log_Space_Used_MB,log_Free_Space_MB)
exec sp_msforeachdb
'use [?];
  select DB_NAME() AS DbName,
sum(size)/128.0 AS Log_File_Size_MB,
sum(CAST(FILEPROPERTY(name, ''SpaceUsed'') AS INT))/128.0 as log_Space_Used_MB,
SUM( size)/128.0 - sum(CAST(FILEPROPERTY(name,''SpaceUsed'') AS INT))/128.0 AS log_Free_Space_MB 
from sys.database_files  where type=1 group by type'
 
--------------------------------database free size
  if exists (select * from tempdb.sys.all_objects where name like '%#dbfreesize%')
drop table #dbfreesize
create table #dbfreesize
(name varchar(500),
database_size varchar(500),
Freespace varchar(500)default (0.00))
 
insert into #dbfreesize(name,database_size,Freespace)
exec sp_msforeachdb
'use ?;SELECT database_name = db_name()
    ,database_size = ltrim(str((convert(DECIMAL(15, 2), dbsize) + convert(DECIMAL(15, 2), logsize)) * 8192 / 1048576, 15, 2) + ''MB'')
    ,''unallocated space'' = ltrim(str((
                CASE 
                    WHEN dbsize >= reservedpages
                        THEN (convert(DECIMAL(15, 2), dbsize) - convert(DECIMAL(15, 2), reservedpages)) * 8192 / 1048576
                    ELSE 0
                    END
                ), 15, 2) + '' MB'')
FROM (
    SELECT dbsize = sum(convert(BIGINT, CASE 
                    WHEN type = 0
                        THEN size
                    ELSE 0
                    END))
        ,logsize = sum(convert(BIGINT, CASE 
                    WHEN type <> 0
                        THEN size
                    ELSE 0
                    END))
    FROM sys.database_files
) AS files
,(
    SELECT reservedpages = sum(a.total_pages)
        ,usedpages = sum(a.used_pages)
        ,pages = sum(CASE 
                WHEN it.internal_type IN (
                        202
                        ,204
                        ,211
                        ,212
                        ,213
                        ,214
                        ,215
                        ,216
                        )
                    THEN 0
                WHEN a.type <> 1
                    THEN a.used_pages
                WHEN p.index_id < 2
                    THEN a.data_pages
                ELSE 0
                END)
    FROM sys.partitions p
    INNER JOIN sys.allocation_units a
        ON p.partition_id = a.container_id
    LEFT JOIN sys.internal_tables it
        ON p.object_id = it.object_id
) AS partitions'
-----------------------------------
 
if exists (select * from tempdb.sys.all_objects where name like '%#alldbstate%')
drop table #alldbstate 
create table #alldbstate 
(dbname varchar(250),
DBstatus varchar(250),
R_model Varchar(200))
  
--select * from sys.master_files
 
insert into #alldbstate (dbname,DBstatus,R_model)
select name,CONVERT(varchar(200),DATABASEPROPERTYEX(name,'status')),recovery_model_desc from sys.databases
--select * from #dbsize
 
insert into #dbsize(Dbname,dbstatus,Recovery_Model)
select dbname,dbstatus,R_model from #alldbstate where DBstatus <> 'online'
 
insert into #logsize(Dbname)
select dbname from #alldbstate where DBstatus <> 'online'
 
insert into #dbfreesize(name)
select dbname from #alldbstate where DBstatus <> 'online'
 
INSERT INTO  SQL_Monitoring.dbo.DB_SIZES 

(Instance,RAN_DATE,DB_NAME,DB_STATUS,RECOVERY_MODEL,DB_SIZE,FILE_SIZE_MB,SPACE_USED_MB,FREE_SPACE_MB,LOG_FILE_MB,LOG_SPACE_USED_MB,LOG_FREE_SPACE_MB,DB_FREESPACE)

select 
@@servername as Instance,
getdate() as Ran_Date,
d.Dbname,d.dbstatus,d.Recovery_Model,
(file_size_mb + log_file_size_mb) as DBsize,
d.file_Size_MB,d.Space_Used_MB,d.Free_Space_MB,
l.Log_File_Size_MB,log_Space_Used_MB,l.log_Free_Space_MB,fs.Freespace as DB_Freespace
from #dbsize d join #logsize l 
on d.Dbname=l.Dbname join #dbfreesize fs 
on d.Dbname=fs.name
order by Dbname
--------------------------------------------------------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[usp_drive_space_free]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/01 V3.0
-- Added Drive space free
-- Item:	usp_drive_space_free Agent Job fails
-- Description Part of suite of scripts for monitoring
-- =============================================
CREATE PROCEDURE [dbo].[usp_drive_space_free]
AS
INSERT INTO [SQL_Monitoring].[dbo].[DRIVE_SPACE_FREE]

SELECT  @@servername as Instance
    ,getdate() AS Ran_Date
    ,   Drive
    ,   TotalSpaceGB
    ,   FreeSpaceGB
    ,   PctFree
    FROM
    (SELECT DISTINCT
        SUBSTRING(dovs.volume_mount_point, 1, 10) AS Drive
    ,   CONVERT(INT, dovs.total_bytes / 1024.0 / 1024.0 / 1024.0) AS TotalSpaceGB
    ,   CONVERT(INT, dovs.available_bytes / 1048576.0) / 1024 AS FreeSpaceGB
    ,   CAST(ROUND(( CONVERT(FLOAT, dovs.available_bytes / 1048576.0) / CONVERT(FLOAT, dovs.total_bytes / 1024.0 /
                         1024.0) * 100 ), 2) AS NVARCHAR(50)) AS PctFree
              
    FROM    sys.master_files AS mf
    CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.file_id) AS dovs) AS DE
--------------------------------------------------------------------------------------------


GO
/****** Object:  StoredProcedure [dbo].[usp_failed_jobs]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/01 V4.0
-- Item:	Inserts Agent Job fails into table SQL_Monitoring.dbo.job_fails
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- based on number of days @numdays, Example Exec usp_failed_jobs 1  (1 day fails)
-- Description Part of suite of scripts for monitoring
-- =============================================
--run daily

CREATE PROCEDURE [dbo].[usp_failed_jobs] @numdays INT = 1
AS

INSERT INTO [SQL_Monitoring].[dbo].[JOB_FAILS] 
([Instance],[Ran_date],[Job_name],[Job_step],[Error_message])

SELECT @@servername,MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) AS job_ran_time
    ,j.name AS job_name,js.step_id AS job_step,jh.message AS error_message
    FROM msdb.dbo.sysjobs AS j
    INNER JOIN msdb.dbo.sysjobsteps AS js ON js.job_id = j.job_id
    INNER JOIN msdb.dbo.sysjobhistory AS jh ON jh.job_id = j.job_id AND jh.step_id = js.step_id
    WHERE jh.run_status = 0 
	AND MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) >= GETDATE()- @numdays

-------------------------------------------------------------------------------------------------

GO
/****** Object:  StoredProcedure [dbo].[usp_find_unused_logins]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_find_unused_logins] @domain Varchar(30) = 'Sandlnk'

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/01 V2.0
-- Item: finds unused old logins and generates drop script output
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- passes a single name example exec usp_find_unused_logins '<domainname>'
-- Description Part of suite of scripts for monitoring 
-- =============================================
AS

declare @user sysname

declare recscan cursor for

select name from sys.server_principals
where type IN ('U','G') and name like @domain+'%'
 
open recscan 
fetch next from recscan into @user
 
while @@fetch_status = 0
begin
    begin try
        exec xp_logininfo @user
    end try
    begin catch
        --Error on xproc because login doesn't exist
        print 'drop login ['+convert(varchar(100),@user+']')
    end catch
 
    fetch next from recscan into @user
end
 
close recscan
deallocate recscan

GO
/****** Object:  StoredProcedure [dbo].[usp_fragmentation]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/01 V2.0
-- Item:	usp_fragmentation fragmented percent 20% more than 2000 pages only
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_fragmentation]
 AS

EXEC [SQL_Monitoring].[dbo].[SP_run_query_across_databases]'

INSERT INTO SQL_Monitoring.dbo.Fragmentation
([Instance],[Ran_Date],[Databasename],[Tablename],[Indexname],[Fragpercent],[IndexType],[Page_count]
)
SELECT @@servername As Instance,
getdate()AS Ran_Date,
SUBSTRING (db_name(),1,20) as DatabaseName, 
SUBSTRING (OBJECT_NAME (sysst.object_id),1,30) as tablename,
SUBSTRING (sysind.name,1,50) as IndexName,
avg_fragmentation_in_percent as fragpercent, 
SUBSTRING (index_type_desc,1,20)as IndexType,
sysst.page_count as page_count

  FROM sys.dm_db_index_physical_stats (db_id(), NULL, NULL, NULL, NULL) AS sysst
      JOIN sys.indexes AS sysind
       ON sysst.object_id = sysind.object_id AND sysst.index_id = sysind.index_id
       WHERE sysst.index_id <> 0 and avg_fragmentation_in_percent >20
	   AND sysst.page_count >=2000'
GO
/****** Object:  StoredProcedure [dbo].[usp_get_failed_login_list]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/08 V6.0 added @@SERVERNAME,ran_date and added @days variable
-- Item:	    failed_logins last 1 days
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Added:       email alerting + removed <local machine> entries
-- Description: Part of suite of scripts for monitoring
-- =============================================

CREATE PROC [dbo].[usp_get_failed_login_list] @days INT = 7
AS


BEGIN
   SET NOCOUNT ON

   DECLARE @ErrorLogCount INT 
   DECLARE @LastLogDate DATETIME
   DECLARE @ErrorLogInfo TABLE (
       LogDate DATETIME
      ,ProcessInfo NVARCHAR (50)
      ,[Text] NVARCHAR (MAX)
      )
   
   DECLARE @EnumErrorLogs TABLE (
       [Archive#] INT
      ,[Date] DATETIME
      ,LogFileSizeMB INT
      )

   INSERT INTO @EnumErrorLogs
   EXEC sp_enumerrorlogs

   SELECT @ErrorLogCount = MIN([Archive#]), @LastLogDate = MAX([Date])
   FROM @EnumErrorLogs

   WHILE @ErrorLogCount IS NOT NULL
   BEGIN

      INSERT INTO @ErrorLogInfo
      EXEC sp_readerrorlog @ErrorLogCount

      SELECT @ErrorLogCount = MIN([Archive#]), @LastLogDate = MAX([Date])
      FROM @EnumErrorLogs
      WHERE [Archive#] > @ErrorLogCount
      AND @LastLogDate > getdate() - @days
  
   END

   -- List all last week failed logins count of attempts and the Login failure message
   TRUNCATE TABLE SQL_Monitoring.dbo.FAILED_LOGINS

   --INSERT INTO SQL_Monitoring.dbo.FAILED_LOGINS
   SELECT @@servername AS instance,
   getdate() AS Ran_date,
   COUNT (TEXT) AS NumberOfAttempts, TEXT AS Details, MIN(LogDate) as MinLogDate, MAX(LogDate) as MaxLogDate
   FROM @ErrorLogInfo
   WHERE ProcessInfo = 'Logon'
      AND TEXT LIKE '%fail%'
      AND LogDate > getdate() - @days
   GROUP BY TEXT
   ORDER BY NumberOfAttempts DESC
   -----added 17/03/22
   --DELETE  @ErrorLogInfo
  END    
   
----------------------------------------------------------------------------
IF NOT EXISTS ( select 1 from SQL_Monitoring.dbo.FAILED_LOGINS WHERE MaxLogDate > getdate()-1 AND details NOT LIKE '%<local machine>%' )
BEGIN
 PRINT 'empty table... no failed logins'  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body = 'Failed logins......',
    @query = 'SET NOCOUNT ON PRINT ''Failed Logins Last 1 Day''
    SELECT  [NumberOfAttempts]AS Attempts,
    SUBSTRING([Details],1, 190)AS Details,
    @@SERVERNAME AS Servername,
    [MinLogDate]AS Oldest_attempt,
    [MaxLogDate]AS Latest_attempt
     FROM SQL_Monitoring.dbo.FAILED_LOGINS WHERE MaxLogDate > getdate()-1 AND details NOT LIKE ''%<local machine>%'' ',
    @subject = 'ALERTS-SLKBRHSQLDSCN02\DEVELOPMENT LOGIN FAILS LAST 1 DAY' ,
	@attach_query_result_as_file = 1,
	@query_attachment_filename = '1_daysLoginFails.txt';  ; 
PRINT 'Login fails occurred in last 1 day'

GO
/****** Object:  StoredProcedure [dbo].[usp_getcpu_use]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/05 V3.0
-- Item:	Connection Monitor
-- Description Part of suite of scripts for monitoring
-- stored procedure used to insert CPU usage data into table CPU_USAGE
-- single parameter required number in mins 59 would be an hour . An hourly job required to populate the table
-- =============================================

CREATE PROCEDURE [dbo].[usp_getcpu_use]

@mins INT =5

AS

BEGIN
DECLARE @ts_now BIGINT = (SELECT cpu_ticks/(cpu_ticks/ms_ticks)FROM sys.dm_os_sys_info); 

INSERT INTO SQL_MONITORING.DBO.CPU_Usage (SQL_CPU_UTILISATION,Instance,SYSTEM_IDLE,OTHER_CPU_UTILISATION,Ran_date)

SELECT TOP(@mins) SQLProcessUtilization AS [SQL Server Process CPU Utilization], 
               @@servername As Instance,
               SystemIdle AS [System Idle Process], 
               100 - SystemIdle - SQLProcessUtilization AS [Other Process CPU Utilization], 
               DATEADD(ms, -1 * (@ts_now - [timestamp]), GETDATE()) AS [Event Time] 
FROM ( 
	  SELECT record.value('(./Record/@id)[1]', 'int') AS record_id, 
			record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int') 
			AS [SystemIdle], 
			record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 
			'int') 
			AS [SQLProcessUtilization], [timestamp] 
	  FROM ( 
			SELECT [timestamp], CONVERT(xml, record) AS [record] 
			FROM sys.dm_os_ring_buffers 
			WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR' 
			AND record LIKE '%<SystemHealth>%') AS x 
	  ) AS y 

  END
GO
/****** Object:  StoredProcedure [dbo].[usp_last_backup]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/05 V5.0
-- Item:	last_backup added email alerting added HA column
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_last_backup]

-------------------------------------------------------------------------------------------------------
AS
INSERT INTO [SQL_Monitoring].[dbo].[BACKUPS] (Instance,Ran_date,HA_Primary,Database_name,DaysSinceLastBackup,LastBackupDate,BackupType)

SELECT @@servername AS Instance,
                getdate()AS run_date,
                SERVERPROPERTY ('IsHadrEnabled')AS 'HA_Primary',
                SUBSTRING(B.name,1,30) AS Database_name, ISNULL(STR(ABS(DATEDIFF(day, GetDate(), 
                MAX(Backup_finish_date)))), 'NEVER') AS DaysSinceLastBackup,
                ISNULL(Convert(char(10), MAX(backup_finish_date), 101), 'NEVER') AS LastBackupDate,
				A.type AS 'TYPE'
                FROM master.dbo.sysdatabases B LEFT OUTER JOIN msdb.dbo.backupset A 
                ON A.Database_name = B.name 
				AND A.type = 'D' 
				OR A.type = 'I'  
				OR A.type = 'L'
                WHERE B.name NOT IN ('Tempdb','model')
                GROUP BY B.name, A.type
				ORDER BY B.name
  ----------------------------------------------------------------------------------------
 /* REM out this section as superseded by SP_Missing_backup
 20/03/22 APS
 IF NOT EXISTS ( select 1 from [SQL_Monitoring].[dbo].[BACKUPS] )
BEGIN
 PRINT 'empty table... '  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body = 'SQL Backup Issues',
    @query = 'SET NOCOUNT ON PRINT ''Backup Issues on SLKBRHSQLDSCN02\DEVELOPMENT''
    SELECT 
        SUBSTRING(@@servername,1,40),
		[Run_Date],
        [Database_Name],
        [DaysSinceLastBackup],
        [LastBackupDate],
        [BackupType]
  FROM [SQL_Monitoring].[dbo].[BACKUPS]

  WHERE [Run_date] >= getdate()-1
  
  AND  [BackupType]= ''D'' AND DaysSinceLastBackup >=1

  OR   [BackupType]= ''I'' AND DaysSinceLastBackup > 1
  
  OR   [BackupType]= ''L'' AND DaysSinceLastBackup  >=2
	ORDER BY Database_Name ASC',
    
	@subject = 'ALERTS- SLKBRHSQLDSCN02\DEVELOPMENT BACKUP ISSUES' ,
	@attach_query_result_as_file = 1,
	@query_attachment_filename = 'BackupIssues.txt';  
PRINT 'Backup Issues '
*/

GO
/****** Object:  StoredProcedure [dbo].[usp_last_db_used]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/08 V2.last time database used from restart
-- Added run_date andinstance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================
CREATE Procedure [dbo].[usp_last_db_used]
AS
INSERT INTO [dbo].[LAST_USED_DB]
([Ran_date],[Instance],[Last_Restart],[DbName],[Last_User_Seek],[Last_User_Scan],[Last_User_Lookup],[Last_User_Update])

SELECT  Getdate() as Ran_date,
@@Servername as Instance,
(SELECT sqlserver_start_time FROM sys.dm_os_sys_info)As Last_SQL_Restart, 
d.name as DatabaseName,
last_user_seek = MAX(last_user_seek),
last_user_scan = MAX(last_user_scan),
last_user_lookup = MAX(last_user_lookup),
last_user_update = MAX(last_user_update)
FROM sys.dm_db_index_usage_stats AS i
JOIN sys.databases AS d ON i.database_id=d.database_id
WHERE d.name NOT IN ('master','msdb','tempdb')
GROUP BY d.name
GO
/****** Object:  StoredProcedure [dbo].[usp_memory_usage]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/05 V2.0
-- Item:	memory_usage
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_memory_usage]
AS

DECLARE @total_buffer INT;

SELECT @total_buffer = cntr_value
FROM sys.dm_os_performance_counters 
WHERE RTRIM([object_name]) LIKE '%Buffer Manager'
AND counter_name = 'Database Pages';

;WITH src AS
(
SELECT 
database_id, db_buffer_pages = COUNT_BIG(*)
FROM sys.dm_os_buffer_descriptors
--WHERE database_id BETWEEN 5 AND 32766
GROUP BY database_id
)

---table insert
INSERT INTO sql_monitoring.dbo.MEMORY_USAGE

SELECT
@@servername as Instance,
Getdate() AS ran_date,
[db_name] = CASE [database_id] WHEN 32767 
THEN 'Resource DB' 
ELSE DB_NAME([database_id]) END,
db_buffer_pages,
db_buffer_MB = db_buffer_pages / 128,
db_buffer_percent = CONVERT(DECIMAL(6,3), 
db_buffer_pages * 100.0 / @total_buffer)
FROM src
ORDER BY db_buffer_MB DESC;
------------------------------------------------------ 

GO
/****** Object:  StoredProcedure [dbo].[usp_ple]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/02/05 V2.0
-- Item:	Page level expectancy into table SQL_Monitoring.dbo.PLE
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================


CREATE PROCEDURE [dbo].[usp_ple]

AS

INSERT INTO [SQL_Monitoring].[dbo].[PLE] ([Instance],[Ran_date],[Countername],[PagelifeValue])

SELECT @@servername,getdate(),counter_name,cntr_value
FROM sys.dm_os_performance_counters WHERE
object_name like '%Buffer Manager%'
AND counter_name = 'Page life expectancy'  
GO
/****** Object:  StoredProcedure [dbo].[usp_run_query_across_databases]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/01/02 V1.0
-- Item:	run script across all databases
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_run_query_across_databases]
@sql_command VARCHAR(MAX)
AS
BEGIN
       SET NOCOUNT ON;

  DECLARE @database_name VARCHAR(300)           
  DECLARE @sql_command_to_execute NVARCHAR(MAX) 
  DECLARE @database_names TABLE (database_name VARCHAR(100))
  DECLARE @SQL VARCHAR(MAX) 
     SET @SQL =
       '      SELECT
              SD.name AS database_name
              FROM sys.databases SD
       '
  -- Prepare database name list
       INSERT INTO @database_names
               ( database_name )
       EXEC (@SQL)
      
       DECLARE db_cursor CURSOR FOR SELECT database_name FROM @database_names
       OPEN db_cursor

       FETCH NEXT FROM db_cursor INTO @database_name

       WHILE @@FETCH_STATUS = 0
       BEGIN
          SET @sql_command_to_execute = REPLACE(@sql_command, '?', @database_name) 
          EXEC sp_executesql @sql_command_to_execute
          FETCH NEXT FROM db_cursor INTO @database_name
       END

       CLOSE db_cursor;
       DEALLOCATE db_cursor;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_tidy60]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Adrian Sleigh
-- Create date: 2023/03/08 V1.0
-- Item: Housekeeping for monitoring delete old data 60 days
-- exclude tables'CPU_USAGE','CONNECTION_MONITOR','FAILED_LOGINS','LAST_USED_DB','M_VERSION','DB_GROWTH','DB_GROWTH_12'
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_tidy60] AS

DECLARE @tblname Varchar (100), @SQL NVARCHAR(max)  

CREATE TABLE #usertables (
id INT IDENTITY(1,1),tablename Varchar (100)
)
 INSERT INTO #usertables SELECT [name] FROM sys.tables
 WHERE [name] NOT IN ('M_VERSION')
 
 DECLARE tbl_cursor CURSOR FOR
 SELECT tablename FROM #usertables

 OPEN tbl_cursor

 FETCH NEXT FROM tbl_cursor INTO @tblname

 WHILE @@FETCH_STATUS = 0

 BEGIN

 ---print @tblname
 SET @SQL=N'  DELETE FROM '  +@tblname+ ' WHERE Ran_date <= getdate() - 60 '
 PRINT 'Applied script to ' +@tblname+ @SQL
 EXEC (@SQL)

  FETCH NEXT FROM tbl_cursor INTO @tblname

 END
  CLOSE tbl_cursor

 DEALLOCATE tbl_cursor
  DROP TABLE #usertables
GO
/****** Object:  StoredProcedure [dbo].[usp_version]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/03/07 V1.0
-- Item:	database deployed version
-- Added instance column for easier rollup to Master_SQL_Monitoring
-- Description Part of suite of scripts for monitoring
-- =============================================

CREATE PROCEDURE [dbo].[usp_version]
AS
  DECLARE @version Decimal (9,2) = 1.0

  IF 
   EXISTS (SELECT * FROM VERSION)
  BEGIN
    SET @version =  @version + 1.0
	INSERT INTO [SQL_Monitoring].[dbo].[VERSION]
     ([Instance],[dbVersion],[dbDate])

 ( SELECT @@servername,  @version ,  getdate()
 )
  END
    	ELSE

	BEGIN
	  INSERT INTO [SQL_Monitoring].[dbo].[VERSION]
      ([Instance],[dbVersion],[dbDate])

	   ( SELECT @@servername,  @version ,  getdate()
       )
    END

GO
/****** Object:  StoredProcedure [dbo].[usp_worst_queries]    Script Date: 3/9/2023 12:06:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_worst_queries]

AS
-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2023/02/27 V1.0
-- Item:	FROM SQL_MONITORING DATABASE to populate WORST_QUERIES
-- Description Part of suite of scripts for monitoring
---job required to run daily
-- =============================================

EXEC [master].[dbo].[SP_run_query_across_databases]'

INSERT INTO SQL_Monitoring.dbo.WORST_QUERIES ([database_name],[Instance],[Ran_date],[object_name],[max_logical_reads],[max_logical_writes],
[total_RW],[max_elapsed_time_MS],[execution_cost],[last_execution_time],[execution_count],[object_text])

(SELECT TOP 10 db_name() as database_name,
@@servername as Instance,
getdate()as Ran_date,
obj.name, 
max_logical_reads, 
max_logical_writes,
max_logical_reads + max_logical_writes as total_RW,
max_elapsed_time,
max_logical_reads + max_logical_writes/execution_count as execution_cost,
last_execution_time,
execution_count,[text]

FROM sys.dm_exec_query_stats a
CROSS APPLY sys.dm_exec_sql_text(sql_handle) hnd
INNER JOIN sys.sysobjects obj on hnd.objectid = obj.id)
ORDER BY max_elapsed_time DESC
'
---END
GO
USE [master]
GO
ALTER DATABASE [SQL_Monitoring] SET  READ_WRITE 
GO
--------------------------------------------------------------------------------------------------------------

USE [master]
GO
/****** Object:  Database [Master_SQL_Monitoring]    Script Date: 3/9/2023 12:08:01 PM ******/
CREATE DATABASE [Master_SQL_Monitoring]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Master_SQL_Monitoring', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL15.DEVELOPMENT\MSSQL\DATA\Master_SQL_Monitoring.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Master_SQL_Monitoring_log', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL15.DEVELOPMENT\MSSQL\DATA\Master_SQL_Monitoring_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Master_SQL_Monitoring] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Master_SQL_Monitoring].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Master_SQL_Monitoring] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET ARITHABORT OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET RECOVERY FULL 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET  MULTI_USER 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Master_SQL_Monitoring] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Master_SQL_Monitoring] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Master_SQL_Monitoring] SET QUERY_STORE = OFF
GO
USE [Master_SQL_Monitoring]
GO
/****** Object:  User [SANDLNK\BRH3502020]    Script Date: 3/9/2023 12:08:01 PM ******/
CREATE USER [SANDLNK\BRH3502020] FOR LOGIN [SANDLNK\BRH3502020] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Link_SVR]    Script Date: 3/9/2023 12:08:01 PM ******/
CREATE USER [Link_SVR] FOR LOGIN [Link_SVR] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [SANDLNK\BRH3502020]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Link_SVR]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Link_SVR]
GO
/****** Object:  Table [dbo].[M_BACKUPS]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_BACKUPS](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[Ran_Date] [smalldatetime] NULL,
	[HA_Primary] [sql_variant] NULL,
	[Database_Name] [nchar](120) NOT NULL,
	[DaysSinceLastBackup] [smallint] NOT NULL,
	[LastBackupDate] [smalldatetime] NOT NULL,
	[BackupType] [nchar](1) NOT NULL,
 CONSTRAINT [PK_LAST_BACKUP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_BLOCKING]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_BLOCKING](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[Ran_Date] [datetime] NOT NULL,
	[Spid] [int] NOT NULL,
	[Blocked] [int] NOT NULL,
	[LeadBlocker] [int] NOT NULL,
	[BObject] [nvarchar](50) NOT NULL,
	[WaitTime] [int] NOT NULL,
	[LastWaitType] [nchar](20) NOT NULL,
	[PhysicalIO] [int] NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[LastBatch] [datetime] NOT NULL,
	[OpenTran] [int] NOT NULL,
	[BStatus] [nchar](50) NOT NULL,
	[Hostname] [nchar](50) NOT NULL,
	[ProgramName] [nchar](100) NOT NULL,
	[LoginName] [nchar](50) NOT NULL,
 CONSTRAINT [PK_BLOCKING] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_CONNECTION_MONITOR]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_CONNECTION_MONITOR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[LoginName] [nvarchar](100) NULL,
	[Host] [nvarchar](20) NULL,
	[ProgName] [nvarchar](100) NULL,
	[DbName] [nvarchar](50) NULL,
	[Connections] [int] NULL,
	[EarliestLogin] [datetime] NULL,
	[LatestLogin] [datetime] NULL,
	[Status] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_CPU_DETAILS]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_CPU_DETAILS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[Ran_date] [smalldatetime] NOT NULL,
	[object_name] [nchar](100) NULL,
	[text_data] [ntext] NOT NULL,
	[disk_reads] [int] NOT NULL,
	[memory_reads] [int] NOT NULL,
	[executions] [int] NOT NULL,
	[total_cpu_time] [int] NOT NULL,
	[average_cpu_time] [int] NOT NULL,
	[disk_wait_and_cpu_time] [bigint] NOT NULL,
	[memory_writes] [int] NOT NULL,
	[date_cached] [smalldatetime] NOT NULL,
	[database_name] [nchar](100) NULL,
	[last_execution] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_CPU_DETAILS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_CPU_USAGE]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_CPU_USAGE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[SQL_CPU_UTILISATION] [int] NOT NULL,
	[SYSTEM_IDLE] [int] NOT NULL,
	[OTHER_CPU_UTILISATION] [int] NOT NULL,
	[EVENT_TIME] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_CPU_USAGE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_DB_ACTIVITY]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_DB_ACTIVITY](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[collected_date] [smalldatetime] NOT NULL,
	[TotalPageReads] [int] NOT NULL,
	[TotalPageWrites] [int] NOT NULL,
	[Databasename] [nchar](60) NOT NULL,
 CONSTRAINT [PK_DB_ACTIVITY] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_DB_GROWTH]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_DB_GROWTH](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[DatabaseName] [nvarchar](80) NOT NULL,
	[YearMonth] [smallint] NOT NULL,
	[MinSize] [decimal](18, 2) NULL,
	[MaxSize] [decimal](18, 2) NULL,
	[AvgSize] [decimal](18, 2) NULL,
	[Growth] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_DB_GROWTH_12]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_DB_GROWTH_12](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ran_Date] [date] NULL,
	[Servername] [varchar](100) NULL,
	[DatabaseName] [nchar](100) NOT NULL,
	[0] [numeric](18, 0) NULL,
	[-1] [numeric](18, 0) NULL,
	[-2] [numeric](18, 0) NULL,
	[-3] [numeric](18, 0) NULL,
	[-4] [numeric](18, 0) NULL,
	[-5] [numeric](18, 0) NULL,
	[-6] [numeric](18, 0) NULL,
	[-7] [numeric](18, 0) NULL,
	[-8] [numeric](18, 0) NULL,
	[-9] [numeric](18, 0) NULL,
	[-10] [numeric](18, 0) NULL,
	[-11] [numeric](18, 0) NULL,
	[-12] [numeric](18, 0) NULL,
 CONSTRAINT [PK_DB_GROWTH_12] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_DB_SIZES]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_DB_SIZES](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[RAN_DATE] [smalldatetime] NOT NULL,
	[DB_NAME] [nchar](60) NOT NULL,
	[DB_STATUS] [nchar](10) NOT NULL,
	[RECOVERY_MODEL] [nchar](10) NOT NULL,
	[DB_SIZE] [decimal](18, 0) NOT NULL,
	[FILE_SIZE_MB] [decimal](18, 0) NOT NULL,
	[SPACE_USED_MB] [decimal](18, 0) NOT NULL,
	[FREE_SPACE_MB] [decimal](18, 0) NOT NULL,
	[LOG_FILE_MB] [decimal](18, 0) NOT NULL,
	[LOG_SPACE_USED_MB] [decimal](18, 0) NOT NULL,
	[LOG_FREE_SPACE_MB] [decimal](18, 0) NOT NULL,
	[DB_FREESPACE] [nchar](20) NOT NULL,
 CONSTRAINT [PK_DB_SIZES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_DRIVE_SPACE_FREE]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_DRIVE_SPACE_FREE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[Ran_Date] [smalldatetime] NOT NULL,
	[Drive] [nchar](10) NOT NULL,
	[Total_Space_GB] [decimal](18, 0) NOT NULL,
	[Free_Space_GB] [decimal](18, 0) NOT NULL,
	[percent_Free_GB] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_DRIVE_SPACE_FREE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_FAILED_LOGINS]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_FAILED_LOGINS](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[NumberOfAttempts] [smallint] NOT NULL,
	[Details] [ntext] NOT NULL,
	[MinLogDate] [smalldatetime] NOT NULL,
	[MaxLogDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_FAILED_LOGINS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_FRAGMENTATION]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_FRAGMENTATION](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[Ran_Date] [smalldatetime] NOT NULL,
	[Databasename] [nchar](100) NOT NULL,
	[Tablename] [nchar](100) NOT NULL,
	[Indexname] [nchar](100) NOT NULL,
	[Fragpercent] [decimal](18, 0) NOT NULL,
	[IndexType] [nchar](20) NOT NULL,
	[Pagecount] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_JOB_FAILS]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_JOB_FAILS](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[Job_ran] [smalldatetime] NOT NULL,
	[Job_name] [nchar](100) NOT NULL,
	[Job_step] [smallint] NOT NULL,
	[Error_message] [ntext] NULL,
 CONSTRAINT [PK_JOB_FAILS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_LAST_USED_DB]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_LAST_USED_DB](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[Last_Restart] [datetime] NOT NULL,
	[DbName] [nvarchar](50) NOT NULL,
	[Last_User_Seek] [datetime] NULL,
	[Last_User_Scan] [datetime] NULL,
	[Last_User_Lookup] [datetime] NULL,
	[Last_User_Update] [datetime] NULL,
 CONSTRAINT [PK_LAST_USED_DB] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_LOGINS_ISSUE]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_LOGINS_ISSUE](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[ran_date] [smalldatetime] NOT NULL,
	[primary_instance] [nchar](50) NULL,
	[secondary_instance] [nchar](50) NULL,
 CONSTRAINT [PK_LOGINS_ISSUE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_MEMORY_USAGE]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_MEMORY_USAGE](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[Ran_date] [smalldatetime] NOT NULL,
	[DbName] [nchar](50) NOT NULL,
	[DB_buffer_pages] [int] NOT NULL,
	[DB_buffer_MB] [smallint] NOT NULL,
	[DB_buffer_percent] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_MEMORY_USAGE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_PLE]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_PLE](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[TimeRan] [smalldatetime] NOT NULL,
	[Countername] [nchar](25) NOT NULL,
	[PagelifeValue] [int] NOT NULL,
 CONSTRAINT [PK_PLE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_VERSION]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_VERSION](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Version] [nchar](10) NOT NULL,
	[VDate] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[M_WORST_QUERIES]    Script Date: 3/9/2023 12:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_WORST_QUERIES](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[SQL_Instance] [varchar](100) NULL,
	[database_name] [nchar](60) NOT NULL,
	[collected_time] [smalldatetime] NOT NULL,
	[object_name] [nchar](60) NOT NULL,
	[max_logical_reads] [int] NOT NULL,
	[max_logical_writes] [int] NOT NULL,
	[total_RW] [int] NOT NULL,
	[max_elapsed_time_MS] [int] NOT NULL,
	[execution_cost] [int] NOT NULL,
	[last_execution_time] [smalldatetime] NOT NULL,
	[execution_count] [int] NOT NULL,
	[object_text] [text] NOT NULL,
 CONSTRAINT [PK_WORST_QUERIES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [Master_SQL_Monitoring] SET  READ_WRITE 
GO
----------------------------------------------------------------------------------------------------------------





USE [SQL_Monitoring]
GO

/****** Object:  StoredProcedure [dbo].[sp_alert_backup]    Script Date: 1/10/2023 2:59:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_alert_backup]

AS

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/03/16 V2.0
-- Item:	sp_alert_backup sends email alert on issues
-- Description Part of suite of scripts for monitoring
-- =============================================

SELECT getdate()AS run_date,
SUBSTRING(B.name,1,30) AS Database_Name, ISNULL(STR(ABS(DATEDIFF(day, GetDate(), 
                MAX(Backup_finish_date)))), 'NEVER') AS DaysSinceLastBackup,
                ISNULL(Convert(char(10), MAX(backup_finish_date), 101), 'NEVER') AS LastBackupDate,
				A.type AS 'TYPE'
 INTO ##LastBackup 
                FROM MASTER.dbo.sysdatabases B LEFT OUTER JOIN MSDB.dbo.backupset A 
                ON A.database_name = B.name 
				AND A.type = 'D' 
				OR A.type = 'I'  
				OR A.type = 'L'
                WHERE B.name NOT IN ('Tempdb','model')

                GROUP BY B.name, A.type
				ORDER BY B.name

               -----------Return values
			/*	SELECT * FROM ##LastBackup
				WHERE DaysSinceLastBackup >6 AND TYPE = 'D'
				OR    DaysSinceLastBackup >1 AND TYPE = 'I'
				OR    DaysSinceLastBackup >1 AND TYPE = 'L'
			*/	
  ----------------------------------------------------------------------------------------
  	IF NOT EXISTS ( select 1 from ##LastBackup )
BEGIN
 PRINT 'empty table... '  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body = 'SQL Missing Backup Issue',
    @query = 'SET NOCOUNT ON PRINT ''Missing Backups on SLKBRHSQLISCN01\ESECURITY''
          SELECT * FROM ##LastBackup
				WHERE DaysSinceLastBackup >=6 AND TYPE = ''D''
				OR    DaysSinceLastBackup >=1 AND TYPE = ''I''
				OR    DaysSinceLastBackup >=1 AND TYPE = ''L'' ',
    
	@subject = 'ALERTS- SLKBRHSQLISCN01\ESECURITY MISSING BACKUP ISSUES' ,
	@attach_query_result_as_file = 1,
	@query_attachment_filename = 'MissingBackupIssue.txt';  
PRINT 'Missing Backup Issue '
------------------------------------------------------------
GO

USE [SQL_Monitoring]
GO

/****** Object:  StoredProcedure [dbo].[sp_alert_drvspace]    Script Date: 1/10/2023 2:59:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/03/21 V1.0
-- Item:	sp_alert_drvspace alerts space less than 20% free. Run job every 15 mins
-- Description Part of suite of scripts for monitoring
-- =============================================
CREATE PROCEDURE [dbo].[sp_alert_drvspace]
AS
	IF OBJECT_ID(N'tempdb..##drvspace') IS NOT NULL
BEGIN
DROP TABLE ##drvspace
END

CREATE TABLE ##drvspace(ran_date smalldatetime ,drive varchar(4), totalspacegb float, freespacegb float, pctfree float )
INSERT INTO ##drvspace

SELECT  getdate() AS Ran_Date
    ,   Drive
    ,   TotalSpaceGB
    ,   FreeSpaceGB
    ,   PctFree
  FROM
    (SELECT DISTINCT
        SUBSTRING(dovs.volume_mount_point, 1, 10) AS Drive
    ,   CONVERT(INT, dovs.total_bytes / 1024.0 / 1024.0 / 1024.0) AS TotalSpaceGB
    ,   CONVERT(INT, dovs.available_bytes / 1048576.0) / 1024 AS FreeSpaceGB
    ,   CAST(ROUND(( CONVERT(FLOAT, dovs.available_bytes / 1048576.0) / CONVERT(FLOAT, dovs.total_bytes / 1024.0 /
                         1024.0) * 100 ), 2) AS NVARCHAR(50)) AS PctFree
    FROM    sys.master_files AS mf
    CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.file_id) AS dovs) AS DE

  --	SELECT * FROM ##drvspace WHERE pctfree <=20

	IF NOT EXISTS ( SELECT 1 FROM ##drvspace WHERE pctfree <=20 )
BEGIN
 PRINT 'Empty table... no drive space issues '  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body  = 'Drive Space alert in the last 15 mins......Space less than 20% free',
    @query = 'SET NOCOUNT ON PRINT ''Recent drive space alert''
         SELECT * FROM ##drvspace WHERE pctfree <=20 AND ran_date > dateadd(mi,-15,Getdate()) ',
    @subject = 'ALERTS- SLKBRHSQLISCN01\ESECURITY RECENT DRIVE SPACE ALERT LESS THAN 20% FREE', 
	@attach_query_result_as_file = 1,
	@query_attachment_filename = 'RecentDriveSpaceAlert.txt'; 
PRINT 'Recent Drive Space Alert'
GO
USE [SQL_Monitoring]
GO

/****** Object:  StoredProcedure [dbo].[sp_alert_jobfail]    Script Date: 1/10/2023 2:59:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_alert_jobfail]
AS
-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/04/20 V2.0
-- Excluded alerting job
-- Item:	job_fail alert run every 15 mins
-- Description Part of suite of scripts for monitoring
-- =============================================


IF NOT EXISTS( SELECT 1 FROM msdb.dbo.sysjobs AS j
    INNER JOIN msdb.dbo.sysjobsteps AS js ON js.job_id = j.job_id
    INNER JOIN msdb.dbo.sysjobhistory AS jh ON jh.job_id = j.job_id AND jh.step_id = js.step_id
    WHERE jh.run_status = 0 
	AND j.name <> 'alerting'
    AND MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) > dateadd(mi,-15,Getdate())
	)
	BEGIN
 PRINT 'empty table... no job fails' 
 GOTO ENDIT
END
ELSE
PRINT 'FAILED AGENT JOB OCCURRED'
BEGIN
 EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body = 'A FAILED AGENT JOB OCCURRED',
    @query = 'SET NOCOUNT ON PRINT ''FAILED AGENT JOB OCCURRED''
    SELECT  MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) AS job_ran_time,
    SUBSTRING(j.name,1,50) AS job_name,
	js.step_id AS job_step,
	SUBSTRING(jh.message,1,180) AS error_message
     FROM msdb.dbo.sysjobs AS j
      INNER JOIN msdb.dbo.sysjobsteps AS js ON js.job_id = j.job_id
      INNER JOIN msdb.dbo.sysjobhistory AS jh ON jh.job_id = j.job_id AND jh.step_id = js.step_id
         WHERE jh.run_status = 0 
       AND MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) > dateadd(mi,-15,Getdate())',
    @subject = 'ALERTS - SLKBRHSQLISCN01\ESECURITY FAILED AGENT JOB OCCURRED' ,
	@attach_query_result_as_file = 1,
	@query_attachment_filename = 'FAILED_AGENT_JOB_OCCURRED.txt';  

END

ENDIT:
PRINT 'ENDED'
GO
USE [SQL_Monitoring]
GO

/****** Object:  StoredProcedure [dbo].[sp_alert_loginfail]    Script Date: 1/10/2023 3:00:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/03/21 V1.0
-- Item:	sp_alert_loginfail alert run every 15 mins
-- Description Part of suite of scripts for monitoring
-- =============================================
CREATE PROCEDURE [dbo].[sp_alert_loginfail]
AS

IF OBJECT_ID(N'tempdb..##LoginFail') IS NOT NULL
BEGIN
DROP TABLE ##LoginFail
END

CREATE TABLE ##LoginFail(logdate smalldatetime ,processInfo varchar(10), TextDesc Text)
INSERT INTO ##LoginFail
 EXEC sp_readerrorlog 0, 1, 'Login failed' 

IF NOT EXISTS ( select 1 from ##LoginFail )
BEGIN
 PRINT 'empty table... no failed logins'  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'newemailprofile',
    @recipients = 'sqldb.support@baesystems.com;adrian.sleigh@baesystems.com',  
    @body  = 'Failed logins in the last 15 mins......',
    @query = 'SET NOCOUNT ON PRINT ''Recent Failed Logins''
       SELECT * FROM ##LoginFail WHERE logdate > dateadd(mi,-15,Getdate())',
    @subject = 'ALERTS- SLKBRHSQLISCN01\ESECURITY RECENT LOGIN FAILS', 
	@attach_query_result_as_file = 1,
	@query_attachment_filename = 'RecentLoginFails.txt'; 
PRINT 'Recent Login fails present'
GO

-----------------------------------------------------------------------------------------------------------





USE [msdb]
GO

/****** Object:  Job [CPU_Gather]    Script Date: 3/9/2023 12:08:53 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[STATISTICS]]    Script Date: 3/9/2023 12:08:53 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[STATISTICS]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[STATISTICS]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CPU_Gather', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'gathers CPU % usage for each database', 
		@category_name=N'[STATISTICS]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'SQL_DBA_SUPPORT', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run hourly]    Script Date: 3/9/2023 12:08:53 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run hourly', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_getCPU_use 59', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'hourly', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20201124, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'e1e3c2f4-dc55-41e9-80dd-e4d7364aa0a4'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO
USE [msdb]
GO

/****** Object:  Job [PLE_Gather]    Script Date: 3/9/2023 12:09:11 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[STATISTICS]]    Script Date: 3/9/2023 12:09:11 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[STATISTICS]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[STATISTICS]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'PLE_Gather', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Gathers Page Life Expectancy into PLE table in Dba_admin datababase. Run every 5 mins.', 
		@category_name=N'[STATISTICS]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'SQL_DBA_SUPPORT', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Page Life Expectancy]    Script Date: 3/9/2023 12:09:11 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Page Life Expectancy', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_ple', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Blocking]    Script Date: 3/9/2023 12:09:11 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Blocking', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_blocking', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'5 min intervals', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20201124, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'd6ca402e-a666-42d5-bd8a-71f990a4a5f2'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

USE [msdb]
GO

/****** Object:  Job [SQL_Monitoring]    Script Date: 3/9/2023 12:09:25 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[STATISTICS]]    Script Date: 3/9/2023 12:09:25 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[STATISTICS]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[STATISTICS]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'SQL_Monitoring', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[STATISTICS]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Age out Data]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Age out Data', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_tidy60', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Failed Jobs]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Failed Jobs', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_failed_jobs 7', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Last Backup]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Last Backup', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_last_backup

', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Failed Logins]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Failed Logins', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_get_failed_login_list', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Drive Space Free]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Drive Space Free', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_drive_space_free', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Worst Queries]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Worst Queries', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_worst_queries', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Fragmentation]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Fragmentation', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_fragmentation', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Database Sizes]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Database Sizes', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_db_Sizes', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Database Activity]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Database Activity', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_db_Activity', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [CPU Details]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'CPU Details', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_cpu_details', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Memory Usage]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Memory Usage', 
		@step_id=11, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_memory_usage', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DatabaseGrowth]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DatabaseGrowth', 
		@step_id=12, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'TRUNCATE TABLE [dbo].[DB_GROWTH]
GO
INSERT INTO [dbo].[DB_GROWTH]
(
[Ran_Date],[Instance],[DatabaseName],[YearMonth],[MinSize],[MaxSize],[AvgSize],[Growth]
)
EXEC [dbo].[usp_db_growth]

--------------------------------------------------------------------------------------------
TRUNCATE TABLE [dbo].[DB_GROWTH_12]
GO
INSERT INTO [dbo].[DB_GROWTH_12]
(
[Ran_Date],[Instance],[DatabaseName],[0],[-1],[-2],[-3],[-4],[-5],[-6],[-7],[-8],[-9],[-10],[-11],[-12]
)
EXEC [dbo].[usp_db_growth_12]', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Last_Used_DB]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Last_Used_DB', 
		@step_id=13, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-----INSTANCE LEVEL LAST USED OBJECTS
----LAST USED DATABASE
----------------------------------------------------------------------------
INSERT INTO [dbo].[LAST_USED_DB]
([Last_Restart],[DbName],[Last_User_Seek],[Last_User_Scan],[Last_User_Lookup],[Last_User_Update])

SELECT 
(SELECT sqlserver_start_time FROM sys.dm_os_sys_info)As Last_SQL_Restart, 
d.name,
last_user_seek = MAX(last_user_seek),
last_user_scan = MAX(last_user_scan),
last_user_lookup = MAX(last_user_lookup),
last_user_update = MAX(last_user_update)
FROM sys.dm_db_index_usage_stats AS i
JOIN sys.databases AS d ON i.database_id=d.database_id
WHERE d.name NOT IN (''master'',''msdb'',''tempdb'')
GROUP BY d.name', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Login_sync]    Script Date: 3/9/2023 12:09:25 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Login_sync', 
		@step_id=14, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- =============================================
-- Author:		Adrian Sleigh
-- Create date: 2022/03/13 V2.0
-- Item:	Login_sync
-- Description Part of suite of scripts for monitoring added mail
-- Inserts non duplicate logins to table [SQL_Monitoring].dbo.LOGINS_ISSUE 
--Sends email if logins are not in sync to sqldb.support@baesystems.com
-- =============================================

USE SQL_Monitoring

INSERT INTO LOGINS_ISSUE
([ran_date],[primary_instance],[secondary_instance])

SELECT getdate() AS ran_date,
       A.name AS PRIMARY_INSTANCE, 
       B.name AS SECONDARY_INSTANCE
FROM            [SLKBRHSQLDSCN02\DEVELOPMENT].[master].[dbo].[syslogins] A
FULL OUTER JOIN [SLKBRHSQLDSCN01\DEVELOPMENT].[master].[dbo].[syslogins] B
ON A.name =B.name
WHERE A.name NOT LIKE ''##%''
  AND A.name NOT LIKE ''NT%''
  AND B.name IS NULL
  OR A.name IS NULL

  IF NOT EXISTS ( select 1 from [SQL_Monitoring].dbo.LOGINS_ISSUE )
BEGIN
 PRINT ''empty table... all account in sync''  
END
ELSE
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = ''newemailprofile'',
    @recipients = ''sqldb.support@baesystems.com;adrian.sleigh@baesystems.com'',  
    @body = ''Logins on Primary Instance are not the same as Secondary'',
    @query = ''SET NOCOUNT ON PRINT ''''Logins on Primary Instance are not the same as Secondary''''
SELECT SUBSTRING(@@servername,1,40) AS PrimarySQLInstance,
       SUBSTRING(primary_instance,1,40) AS primary_login,
	   SUBSTRING(secondary_instance,1,40)  AS secondary_login
	FROM [SQL_Monitoring].dbo.LOGINS_ISSUE'',
    @subject = ''ALERTS - SLKBRHSQLDSCN02\DEVELOPMENT-SLKBRHSQLDSCN01\DEVELOPMENT LOGINS OUT OF SYNC'' ,
	@attach_query_result_as_file = 1,
	@query_attachment_filename = ''Login_Sync_error.txt'';;  
PRINT ''accounts are not in sync''
GO', 
		@database_name=N'SQL_Monitoring', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily @24:00', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20220206, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'be3b5886-6104-43d3-bad8-c53918a91e39'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO




