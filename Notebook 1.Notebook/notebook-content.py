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
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

df = spark.read.format("csv").option("header","true").load("Files/Staging/month.csv")
# df now is a Spark DataFrame containing CSV data from "Files/Staging/month.csv".
display(df)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
