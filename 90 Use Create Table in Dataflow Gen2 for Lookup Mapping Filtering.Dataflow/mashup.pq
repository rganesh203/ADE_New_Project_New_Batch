[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared #"100 Sales Records csv" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "d6920e28-6009-4d33-bb39-729c3b5ad2c1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "c131d17c-c972-4738-8b6d-6c82265644bf"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 4" = #"Navigation 3"{[Name = "100 Sales Records.csv"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 4", [Delimiter = ",", Columns = 14, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"Region", type text}, {"Country", type text}, {"Item Type", type text}, {"Sales Channel", type text}, {"Order Priority", type text}, {"Order Date", type date}, {"Order ID", Int64.Type}, {"Ship Date", type date}, {"Units Sold", Int64.Type}, {"Unit Price", type number}, {"Unit Cost", type number}, {"Total Revenue", type number}, {"Total Cost", type number}, {"Total Profit", type number}})
in
  #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Region Table_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Region ID", DestinationColumnName = "Region ID"], [SourceColumnName = "Region Code", DestinationColumnName = "Region Code"], [SourceColumnName = "Region Country", DestinationColumnName = "Region Country"], [SourceColumnName = "Region", DestinationColumnName = "Region"], [SourceColumnName = "Country", DestinationColumnName = "Country"], [SourceColumnName = "Item Type", DestinationColumnName = "Item Type"], [SourceColumnName = "Sales Channel", DestinationColumnName = "Sales Channel"], [SourceColumnName = "Order Priority", DestinationColumnName = "Order Priority"], [SourceColumnName = "Order Date", DestinationColumnName = "Order Date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"Region Table" = let
  Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WMlTSUXINBRGlRfkFqUqxOtFKRkCuY2kxhCwpSszJTASLG4NE0sBEUWYyRMwEyPVzBBH5RSUZCo65qRCpWAA=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [#"Region ID" = _t, #"Region Code" = _t, #"Region Country" = _t]),
  #"Changed column type" = Table.TransformColumnTypes(Source, {{"Region ID", Int64.Type}, {"Region Code", type text}, {"Region Country", type text}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type", {"Region Country"}, #"100 Sales Records csv", {"Region"}, "100 Sales Records csv", JoinKind.LeftOuter),
  #"Expanded 100 Sales Records csv" = Table.ExpandTableColumn(#"Merged queries", "100 Sales Records csv", {"Region", "Country", "Item Type", "Sales Channel", "Order Priority", "Order Date"}, {"Region", "Country", "Item Type", "Sales Channel", "Order Priority", "Order Date"})
in
  #"Expanded 100 Sales Records csv";
shared #"Region Table_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "71b4a314-d6aa-4a9f-8d58-212ca6ec7ace"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "bfeb9fee-509d-4258-975c-fc8f8a05be9b"]}[Data],
  TableNavigation = Navigation_2{[Item = "Region Table", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
