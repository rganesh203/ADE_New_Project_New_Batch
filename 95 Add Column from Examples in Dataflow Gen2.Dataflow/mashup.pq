[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "1 csv_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "OrderID", DestinationColumnName = "OrderID"], [SourceColumnName = "CustomerName", DestinationColumnName = "CustomerName"], [SourceColumnName = "Region", DestinationColumnName = "Region"], [SourceColumnName = "Product", DestinationColumnName = "Product"], [SourceColumnName = "Quantity", DestinationColumnName = "Quantity"], [SourceColumnName = "UnitPrice", DestinationColumnName = "UnitPrice"], [SourceColumnName = "Status", DestinationColumnName = "Status"], [SourceColumnName = "Text Before Delimiter", DestinationColumnName = "Text Before Delimiter"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"1 csv" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "d6920e28-6009-4d33-bb39-729c3b5ad2c1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f0e063ed-797d-4cc3-b4d2-7d1438570332"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 4" = #"Navigation 3"{[Name = "1.csv"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 4", [Delimiter = ",", Columns = 7, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"OrderID", Int64.Type}, {"CustomerName", type text}, {"Region", type text}, {"Product", type text}, {"Quantity", Int64.Type}, {"UnitPrice", Int64.Type}, {"Status", type text}}),
  #"Inserted Text Before Delimiter" = Table.AddColumn(#"Changed column type", "Text Before Delimiter", each Text.BeforeDelimiter(Text.Lower([CustomerName]), " "), type text)
in
  #"Inserted Text Before Delimiter";
shared #"1 csv_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "71b4a314-d6aa-4a9f-8d58-212ca6ec7ace"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "bfeb9fee-509d-4258-975c-fc8f8a05be9b"]}[Data],
  TableNavigation = Navigation_2{[Item = "1 csv", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
