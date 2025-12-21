# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "4ea02a8a-4ba6-4965-939c-3a720db3ba47",
# META       "default_lakehouse_name": "Lakehouse_for_files",
# META       "default_lakehouse_workspace_id": "71b4a314-d6aa-4a9f-8d58-212ca6ec7ace",
# META       "known_lakehouses": [
# META         {
# META           "id": "4ea02a8a-4ba6-4965-939c-3a720db3ba47"
# META         },
# META         {
# META           "id": "41e942e9-7f35-48d3-9bfc-0a5e404a4e3b"
# META         },
# META         {
# META           "id": "c131d17c-c972-4738-8b6d-6c82265644bf"
# META         },
# META         {
# META           "id": "99ea534f-c37f-442b-bede-d6fe937740c4"
# META         },
# META         {
# META           "id": "ca79b4d1-0e25-4dfc-9e18-7182ebfbb74a"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

df = spark.read.format("csv").option("inferschema","true").option("header","true").load("abfss://Other_Developers@onelake.dfs.fabric.microsoft.com/Files.Lakehouse/Files/100 Sales Records.csv")
# df now is a Spark DataFrame containing CSV data from "abfss://Other_Developers@onelake.dfs.fabric.microsoft.com/Files.Lakehouse/Files/100 Sales Records.csv".
display(df)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
