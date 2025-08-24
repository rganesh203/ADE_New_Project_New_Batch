[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "sample csv_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "North", DestinationColumnName = "North"], [SourceColumnName = "South", DestinationColumnName = "South"], [SourceColumnName = "East", DestinationColumnName = "East"], [SourceColumnName = "West", DestinationColumnName = "West"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"sample csv" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "d6920e28-6009-4d33-bb39-729c3b5ad2c1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "c131d17c-c972-4738-8b6d-6c82265644bf"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 4" = #"Navigation 3"{[Name = "sample.csv"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 4", [Delimiter = ",", Columns = 4, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"Region", type text}, {"Jan", Int64.Type}, {"Feb", Int64.Type}, {"Mar", Int64.Type}}),
  #"Transposed table" = Table.Transpose(#"Changed column type"),
  #"Promoted headers 1" = Table.PromoteHeaders(#"Transposed table", [PromoteAllScalars = true]),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Promoted headers 1", {{"North", Int64.Type}, {"South", Int64.Type}, {"East", Int64.Type}, {"West", Int64.Type}})
in
  #"Changed column type 1";
shared #"sample csv_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "71b4a314-d6aa-4a9f-8d58-212ca6ec7ace"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "bfeb9fee-509d-4258-975c-fc8f8a05be9b"]}[Data],
  TableNavigation = Navigation_2{[Item = "sample csv", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
