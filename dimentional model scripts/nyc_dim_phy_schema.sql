/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      nyc_dim.DM1
 *
 * Date Created : Monday, February 13, 2023 21:41:24
 * Target DBMS : Microsoft SQL Server 2019
 */

/* 
 * TABLE: Dim_Action 
 */
GO
CREATE DATABASE NYC_INSPECTION_DIM;
GO
USE NYC_INSPECTION_DIM 
CREATE TABLE Dim_Action(
    Action_SK              bigint           NOT NULL,
    Action                 varchar(1000)    NULL,
    DI_CreateDate          timestamp        NULL,
    DI_WorkflowFileName    nchar(1000)      NULL,
    CONSTRAINT PK6_1 PRIMARY KEY NONCLUSTERED (Action_SK)
)

go


IF OBJECT_ID('Dim_Action') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Action >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Action >>>'
go

/* 
 * TABLE: Dim_Business 
 */

CREATE TABLE Dim_Business(
    Business_SK            bigint         NOT NULL,
    CAMIS                  int            IDENTITY(1,1),
    DBA                    varchar(95)    NULL,
    BORO                   varchar(13)    NULL,
    BUILDING               varchar(10)    NULL,
    STREET                 varchar(40)    NULL,
    ZIPCODE                nchar(5)       NULL,
    PHONE                  nchar(12)      NULL,
    [CUISINE DESCRIPTION]  varchar(30)    NULL,
    DI_CreateDate          timestamp      NULL,
    DI_WorkflowFileName    nchar(1000)    NULL,
    CONSTRAINT PK10 PRIMARY KEY NONCLUSTERED (Business_SK)
)

go


IF OBJECT_ID('Dim_Business') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Business >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Business >>>'
go

/* 
 * TABLE: Dim_Date 
 */

CREATE TABLE Dim_Date(
    DateSK                 date            NOT NULL,
    FullDateAK             date            NOT NULL,
    WeekNumberOfYear       int             NOT NULL,
    MonthName              nvarchar(10)    NOT NULL,
    MonthNumberOfYear      int             NOT NULL,
    CalendarYear           smallint        NOT NULL,
    DI_CreateDate          timestamp       NULL,
    DI_WorkflowFileName    nchar(1000)     NULL,
    CONSTRAINT PK__Dim_Date__A4262D75D6BC5B9B PRIMARY KEY NONCLUSTERED (DateSK)
)

go


IF OBJECT_ID('Dim_Date') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Date >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Date >>>'
go

/* 
 * TABLE: Dim_Geography 
 */

CREATE TABLE Dim_Geography(
    Geo_SK                 bigint         NOT NULL,
    BUILDING               varchar(10)    NULL,
    BORO                   varchar(13)    NULL,
    ZIPCODE                nchar(5)       NULL,
    STREET                 varchar(40)    NULL,
    DI_CreateDate          timestamp      NULL,
    DI_WorkflowFileName    nchar(1000)    NULL,
    CONSTRAINT PK8 PRIMARY KEY NONCLUSTERED (Geo_SK)
)

go


IF OBJECT_ID('Dim_Geography') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Geography >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Geography >>>'
go

/* 
 * TABLE: Dim_InspectionType 
 */

CREATE TABLE Dim_InspectionType(
    Inspection_SK          bigint           NOT NULL,
    [Inspection Type]      varchar(1000)    NULL,
    DI_CreateDate          timestamp        NULL,
    DI_WorkflowFileName    nchar(1000)      NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (Inspection_SK)
)

go


IF OBJECT_ID('Dim_InspectionType') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_InspectionType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_InspectionType >>>'
go

/* 
 * TABLE: Dim_Violation 
 */

CREATE TABLE Dim_Violation(
    Violation_SK             bigint           NOT NULL,
    [VIOLATION CODE]         nchar(5)         NULL,
    [VIOLATION DESCRIPTION]  varchar(1000)    NULL,
    [CRITICAL FLAG]          nchar(100)       NULL,
    DI_CreateDate            timestamp        NULL,
    DI_WorkflowFileName      nchar(1000)      NULL,
    CONSTRAINT PK11 PRIMARY KEY NONCLUSTERED (Violation_SK)
)

go


IF OBJECT_ID('Dim_Violation') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Violation >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Violation >>>'
go

/* 
 * TABLE: [Fact-Results] 
 */

CREATE TABLE [Fact-Results](
    Sales_SK               bigint         NOT NULL,
    Inspection_SK          bigint         NOT NULL,
    Geo_SK                 bigint         NOT NULL,
    Business_SK            bigint         NOT NULL,
    Violation_SK           bigint         NOT NULL,
    InspectionDate_F       date           NOT NULL,
    RecordDate_F           date           NOT NULL,
    GradeDate_F            date           NOT NULL,
    Action_SK              bigint         NOT NULL,
    SCORE                  tinyint        NULL,
    GRADE                  char(10)       NULL,
    DI_CreateDate          timestamp      NULL,
    DI_WorkflowFileName    nchar(1000)    NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (Sales_SK)
)

go


IF OBJECT_ID('Fact-Results') IS NOT NULL
    PRINT '<<< CREATED TABLE Fact-Results >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Fact-Results >>>'
go

/* 
 * TABLE: [Fact-Results] 
 */

ALTER TABLE [Fact-Results] ADD CONSTRAINT RefDim_Geography1 
    FOREIGN KEY (Geo_SK)
    REFERENCES Dim_Geography(Geo_SK)
go

ALTER TABLE [Fact-Results] ADD CONSTRAINT RefDim_Business2 
    FOREIGN KEY (Business_SK)
    REFERENCES Dim_Business(Business_SK)
go

ALTER TABLE [Fact-Results] ADD CONSTRAINT RefDim_Violation3 
    FOREIGN KEY (Violation_SK)
    REFERENCES Dim_Violation(Violation_SK)
go

ALTER TABLE [Fact-Results] ADD CONSTRAINT RefDim_Date4 
    FOREIGN KEY (InspectionDate_F)
    REFERENCES Dim_Date(DateSK)
go

ALTER TABLE [Fact-Results] ADD CONSTRAINT RefDim_Date5 
    FOREIGN KEY (RecordDate_F)
    REFERENCES Dim_Date(DateSK)
go

ALTER TABLE [Fact-Results] ADD CONSTRAINT RefDim_Date6 
    FOREIGN KEY (GradeDate_F)
    REFERENCES Dim_Date(DateSK)
go

ALTER TABLE [Fact-Results] ADD CONSTRAINT RefDim_InspectionType7 
    FOREIGN KEY (Inspection_SK)
    REFERENCES Dim_InspectionType(Inspection_SK)
go

ALTER TABLE [Fact-Results] ADD CONSTRAINT RefDim_Action8 
    FOREIGN KEY (Action_SK)
    REFERENCES Dim_Action(Action_SK)
go


