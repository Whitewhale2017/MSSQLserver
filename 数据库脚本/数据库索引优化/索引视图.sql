SET ANSI_NULLS ON
SET ANSI_PADDING ON  
SET ANSI_WARNINGS   ON
SET ARITHABORT  ON 
SET CONCAT_NULL_YIELDS_NULL  ON 
--SET QUOTED_IDENTIFIERS   ON
SET NUMERIC_ROUNDABORT  OFF   
CREATE UNIQUE CLUSTERED INDEX IX_View_OrderDetailSummary
ON dbo.View_OrderDetail(
SalesPlatformID, SiteCode, SiteInfoID, ProductCode, SalesGroupID, DistributeAreaID, TransportType, CategoryLevel1, CategoryLevel2, 
PaymnetTimeDimensionID, IsAdorn, ProductStatusID, NameCN, ProductRemarkID,SellerAccountID, CategoryInfoID)

