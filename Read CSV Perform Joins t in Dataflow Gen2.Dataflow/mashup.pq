[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "new 4 csv_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id", DestinationColumnName = "id"], [SourceColumnName = "name", DestinationColumnName = "name"], [SourceColumnName = "salary", DestinationColumnName = "salary"], [SourceColumnName = "city", DestinationColumnName = "city"], [SourceColumnName = "new csv.id", DestinationColumnName = "new csv.id"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"new 4 csv" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "d6920e28-6009-4d33-bb39-729c3b5ad2c1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "c131d17c-c972-4738-8b6d-6c82265644bf"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 4" = #"Navigation 3"{[Name = "new 4.csv"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 4", [Delimiter = ",", Columns = 4, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"id", Int64.Type}, {"name", type text}, {"salary", Int64.Type}, {"city", type text}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type", {"id"}, #"new csv", {"id"}, "new csv", JoinKind.Inner),
  #"Expanded new csv" = Table.ExpandTableColumn(#"Merged queries", "new csv", {"id"}, {"new csv.id"})
in
  #"Expanded new csv";
shared #"new csv" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "d6920e28-6009-4d33-bb39-729c3b5ad2c1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "c131d17c-c972-4738-8b6d-6c82265644bf"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 4" = #"Navigation 3"{[Name = "new.csv"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 4", [Delimiter = ",", Columns = 4, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"id", Int64.Type}, {"name", type text}, {"age", Int64.Type}, {"city", type text}})
in
  #"Changed column type";
shared #"new 4 csv_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "71b4a314-d6aa-4a9f-8d58-212ca6ec7ace"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "bfeb9fee-509d-4258-975c-fc8f8a05be9b"]}[Data],
  TableNavigation = Navigation_2{[Item = "DF_Join", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
