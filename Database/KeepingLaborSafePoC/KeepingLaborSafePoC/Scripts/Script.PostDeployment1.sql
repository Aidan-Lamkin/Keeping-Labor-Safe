/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

:r .\Initialization\InitializeMetric.sql
:r .\Initialization\InitializeMetricSource.sql
:r .\Initialization\InitializeMetricUnit.sql
:r .\Initialization\InitializeFRIVariable.sql
:r .\Initialization\InitializeTimePeriod.sql
:r .\Initialization\InitializeTimePeriodGroup.sql
:r .\Initialization\InitializeMilestone.sql
:r .\Initialization\InitializeRiskFactorType.sql
:r .\Initialization\InitializeRiskFactorGroup.sql
:r .\Initialization\InitializeRiskFactor.sql