# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "e1e99d91-20ed-46bb-8267-fab484cec62c",
# META       "default_lakehouse_name": "Hema_lake",
# META       "default_lakehouse_workspace_id": "ab99d97a-85ad-4a53-9202-b588338097f2",
# META       "known_lakehouses": [
# META         {
# META           "id": "e1e99d91-20ed-46bb-8267-fab484cec62c"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# Welcome to your new notebook
# Type here in the cell editor to add code!
spark

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

#Create DataFrame
data = [(1, "Alice"), (2, "Bob")]
df = spark.createDataFrame(data, ["id", "name"])

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql import SparkSession
spark = SparkSession.builder \
.appName("DeltaLakeDemo") \
.config("spark.sql.extensions",
"io.delta.sql.DeltaSparkSessionExtension") \
.config("spark.sql.catalog.spark_catalog",
"org.apache.spark.sql.delta.catalog.DeltaCatalog") \
.getOrCreate()

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# Write as Delta table
df.write.format("delta").mode("overwrite").save("/Files/data/delta-table")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df.write.option("mergeSchema", "true") \ .format("delta").mode("append") \.save("/tmp/delta-table")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************



# Write as Delta table
df.write.format("delta").mode("overwrite").save("/Files/data/delta-table")
# Read back
delta_df = spark.read.format("delta").load("/Files/data/delta-table")
delta_df.show()

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
