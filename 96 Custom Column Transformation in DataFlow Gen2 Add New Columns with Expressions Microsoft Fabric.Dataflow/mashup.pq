[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "100 Sales Records csv_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Region", DestinationColumnName = "Region"], [SourceColumnName = "Country", DestinationColumnName = "Country"], [SourceColumnName = "Item Type", DestinationColumnName = "Item Type"], [SourceColumnName = "Sales Channel", DestinationColumnName = "Sales Channel"], [SourceColumnName = "Order Priority", DestinationColumnName = "Order Priority"], [SourceColumnName = "Order Date", DestinationColumnName = "Order Date"], [SourceColumnName = "Order ID", DestinationColumnName = "Order ID"], [SourceColumnName = "Ship Date", DestinationColumnName = "Ship Date"], [SourceColumnName = "Units Sold", DestinationColumnName = "Units Sold"], [SourceColumnName = "Unit Price", DestinationColumnName = "Unit Price"], [SourceColumnName = "Unit Cost", DestinationColumnName = "Unit Cost"], [SourceColumnName = "Total Revenue", DestinationColumnName = "Total Revenue"], [SourceColumnName = "Total Cost", DestinationColumnName = "Total Cost"], [SourceColumnName = "Total Profit", DestinationColumnName = "Total Profit"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"100 Sales Records csv" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "d6920e28-6009-4d33-bb39-729c3b5ad2c1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "c131d17c-c972-4738-8b6d-6c82265644bf"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 4" = #"Navigation 3"{[Name = "100 Sales Records.csv"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 4", [Delimiter = ",", Columns = 14, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"Region", type text}, {"Country", type text}, {"Item Type", type text}, {"Sales Channel", type text}, {"Order Priority", type text}, {"Order Date", type date}, {"Order ID", Int64.Type}, {"Ship Date", type date}, {"Units Sold", Int64.Type}, {"Unit Price", type number}, {"Unit Cost", type number}, {"Total Revenue", type number}, {"Total Cost", type number}, {"Total Profit", type number}}),
  #"Added custom" = Table.AddColumn(#"Changed column type", "Custom", each [Units Sold] * [Unit Price]),
  #"Added custom 1" = Table.AddColumn(#"Added custom", "Custom (2)", each if [Custom]>= 100000 then "High"
else if [Custom]>= 50000 then "medium"
else "low")
in
  #"Added custom 1";
shared #"100 Sales Records csv_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "71b4a314-d6aa-4a9f-8d58-212ca6ec7ace"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "bfeb9fee-509d-4258-975c-fc8f8a05be9b"]}[Data],
  TableNavigation = Navigation_2{[Item = "100 Sales Records", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
