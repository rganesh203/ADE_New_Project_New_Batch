[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Unpivot_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Attribute", DestinationColumnName = "Attribute"], [SourceColumnName = "West", DestinationColumnName = "West"], [SourceColumnName = "South", DestinationColumnName = "South"], [SourceColumnName = "North", DestinationColumnName = "North"], [SourceColumnName = "East", DestinationColumnName = "East"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared Unpivot = let
  Source = Fabric.Warehouse([]),
  #"Navigation 1" = Source{[workspaceId = "71b4a314-d6aa-4a9f-8d58-212ca6ec7ace"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[warehouseId = "bfeb9fee-509d-4258-975c-fc8f8a05be9b"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Schema = "dbo", Item = "Unpivot"]}[Data],
  #"Pivoted column" = Table.Pivot(Table.TransformColumnTypes(#"Navigation 3", {{"Region", type text}}), List.Distinct(Table.TransformColumnTypes(#"Navigation 3", {{"Region", type text}})[Region]), "Region", "Value")
in
  #"Pivoted column";
shared Unpivot_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "71b4a314-d6aa-4a9f-8d58-212ca6ec7ace"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "bfeb9fee-509d-4258-975c-fc8f8a05be9b"]}[Data],
  TableNavigation = Navigation_2{[Item = "pivot", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
