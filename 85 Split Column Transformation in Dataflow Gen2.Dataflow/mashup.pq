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
  #"Split column by delimiter" = Table.SplitColumn(#"Promoted headers", "Region", Splitter.SplitTextByDelimiter("-"), {"Region.1", "Region.2"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Split column by delimiter", {{"Region.1", type text}, {"Region.2", type text}, {"Country", type text}, {"Item Type", type text}, {"Sales Channel", type text}, {"Order Priority", type text}, {"Order Date", type date}, {"Order ID", Int64.Type}, {"Ship Date", type date}, {"Units Sold", Int64.Type}, {"Unit Price", type number}, {"Unit Cost", type number}, {"Total Revenue", type number}, {"Total Cost", type number}, {"Total Profit", type number}})
in
  #"Changed column type";
