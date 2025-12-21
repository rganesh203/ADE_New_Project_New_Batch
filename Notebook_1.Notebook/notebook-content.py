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
# META           "id": "57fc23d8-6262-440f-b576-b539c0408034"
# META         },
# META         {
# META           "id": "c131d17c-c972-4738-8b6d-6c82265644bf"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

df = spark.read.format("csv").option("header","true").load("abfss://Career_BI_Prod@onelake.dfs.fabric.microsoft.com/Lakehouse_Project.Lakehouse/Files/Bronze_Layer/Sales/Territories.csv")
# df now is a Spark DataFrame containing CSV data from "abfss://Career_BI_Prod@onelake.dfs.fabric.microsoft.com/Lakehouse_Project.Lakehouse/Files/Bronze_Layer/Sales/Territories.csv".
display(df)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_filtered = df.filter(df.Continent != "North America")
# or
# df_filtered = df.where("id != 2")

df_filtered.show()


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df = spark.read.format("delta").load("Lakehouse_Project.Lakehouse/Files/Bronze_Layer/Sales/Territories")
display(df)


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
