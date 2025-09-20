# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "c131d17c-c972-4738-8b6d-6c82265644bf",
# META       "default_lakehouse_name": "Files",
# META       "default_lakehouse_workspace_id": "d6920e28-6009-4d33-bb39-729c3b5ad2c1",
# META       "known_lakehouses": [
# META         {
# META           "id": "c131d17c-c972-4738-8b6d-6c82265644bf"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

df = spark.read.format("csv").option("header","true").load("Files/100 Sales Records.csv")
# df now is a Spark DataFrame containing CSV data from "Files/100 Sales Records.csv".
display(df)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
