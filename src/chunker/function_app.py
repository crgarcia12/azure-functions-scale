import azure.functions as func
import logging

app = func.FunctionApp()


@app.blob_trigger(arg_name="myblob", 
    path="raw",
    connection="DefaultEndpointsProtocol=https;AccountName=crgarfuncscalerg;AccountKey=pbiy+AqmqRm9XZ53JYsXFrsNJpqW/Pw3G+xCYVu3ot/+D62clrUkkFSAOd5tWbn3MFhKhr17DL9Y+ASt3vHEwg==;EndpointSuffix=core.windows.net") 
def Chunk(myblob: func.InputStream):
    logging.info(f"Python blob trigger function processed blob"
                f"Name: {myblob.name}"
                f"Blob Size: {myblob.length} bytes")
