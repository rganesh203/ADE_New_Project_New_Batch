# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "99ea534f-c37f-442b-bede-d6fe937740c4",
# META       "default_lakehouse_name": "Files_LH",
# META       "default_lakehouse_workspace_id": "0fcd34f1-88ff-470f-9971-2066f6203f0a",
# META       "known_lakehouses": [
# META         {
# META           "id": "99ea534f-c37f-442b-bede-d6fe937740c4"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

df = spark.read.format("csv").option("header","true").option("infreSchema", "true").load("Files/ga/sales_data_sample.csv")
# df now is a Spark DataFrame containing CSV data from "Files/ga/sales_data_sample.csv".
display(df)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
