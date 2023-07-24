from azure.functions import QueueMessage
import azure.functions as func

import logging

app = func.FunctionApp()

@app.blob_trigger(arg_name="myblob", 
    path="raw",
    connection="StorageAccountConnectionString") 
def Chunk(myblob: func.InputStream):
    logging.info(f"Python blob trigger function processed blob"
                f"Name: {myblob.name}"
                f"Blob Size: {myblob.length} bytes")



@app.queue_trigger(arg_name="azqueue", queue_name="blobchangequeue",
                               connection="StorageAccountConnectionString") 
def blobchange(azqueue: func.QueueMessage):
    logging.info('Python Queue trigger processed a message: %s',
                azqueue.get_body().decode('utf-8'))
