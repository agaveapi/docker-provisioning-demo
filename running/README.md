## Data Management

Agave makes it simple for you to interact with distributed storage systems and services. Later in this tutorial, we will interact with the iPlant Data Store to access our archived data. Before we get there, let's highlight basic actions you can take with Agave's data services.

    The Data Store is a high performance cloud storage system provided free of charge by the [iPlant Collaborative](http://iplantcollaborative.org).

1. List some files

	> files-list $IPLANT_USERNAME
	> files-list shared/imicrobe/southern_ocean_viromes
	> files-list dooley/picksumipsum.txt

2. Upload/download a file/folder

	> files-upload -F agave-cli/README.md $IPLANT_USERNAME
	> files-get dooley/picksumipsum.txt

3. Do some file stuff

	> files-mkdir -N deleteme $IPLANT_USERNAME
	> files-copy -N $IPLANT_USERNAME/deleteme/README2.md $IPLANT_USERNAME/README.md
	> files-rename -N  DELETEME2.md $IPLANT_USERNAME/deleteme/README2.md
	> files-delete  $IPLANT_USERNAME/deleteme

4. Import some data from another system or URL.

	> files-mkdir -N imports $IPLANT_USERNAME
	> files-import -U 'https://assets-cdn.github.com/images/modules/logos_page/Octocat.png' -W ‘$EMAIL_ADDRESS’ $IPLANT_USERNAME/imports
	> files-import  -U 'https://octodex.github.com/images/founding-father.jpg' -W ‘http://requestbin.agaveapi.co/1cl87yo1?event=${EVENT}&path=${PATH}&system=${SYSTEM}’ $IPLANT_USERNAME/imports
	> files-import -U 'agave://rodeo.storage.demo/octocat.jpeg' -W 'http://requestbin.agaveapi.co/1cl87yo1?file=octocat.jpeg&event=${EVENT}' $IPLANT_USERNAME


## Running simulations

Agave provides a common interface for you to run scientific codes on many different platforms, both public and private. There are many publicly provided and curated apps that you can use, or you can publish your own. Additionally, Agave has first class support for running Docker images in a secure, reproducible way. In this section we will look at how to run an existing app, how to run code on your local system in Agave's Docker cloud, and how to run codes you have prepacked as Docker images in Agave's Docker cloud.

### Run existing apps

1. See what apps are already out there

	> apps-list
	> apps-list demo-pyplot-demo-advanced-0.1.0u1
	> apps-list -v demo-pyplot-demo-advanced-0.1.0u1

2. Generate some JSON to make a job request...you probably want to put your email address in the notification section or create your own request bin at [http://requestbin.agaveapi.co](http://requestbin.agaveapi.co).

	> jobs-template demo-pyplot-demo-advanced-0.1.0u1
	> jobs-template -AV demo-pyplot-demo-advanced-0.1.0u1 >  submit.json

3. Submit a job request

	> jobs-submit -V -W -F submit.json

4. Watch progress...check notifications.


### Run your own local code

1. Pull down agave samples project...you can pull down our samples repo for an example you can use.

	> git clone http://bitbucket.org/taccaci/agave-samples.git

2. View pyplot app we just ran

	>  cd agave-samples/apps/pyplot-demo/advanced/pyplot-demo-advanced-0.1.0

3. Run this app in the cloud with Agave. Data will be uploaded, inputs and code staged, a Docker container for python started with the job directory mounted as a volume, the code will be run, then the data archived back to the iplant data store.

	> jobs-run-this -n "my cloud runner job” lib/main.py -v --chart-type=line temp/testdata.csv

4. Pull your output

	> jobs-output $JOB_ID
	> jobs-output -P output $JOB_ID
	> jobs-list -D -P output/plot.png $JOB_ID
	> open plot.png
	> rm plot.png


### Run a custom Docker image

1. Create a Dockerfile for the app. We have one already...

	> cd ../../../docker-demo/pyplot-demo-advanced-0.1.0

2. Run the same as before. This time, the code will run after the Dockerfile is used to build the user image.

	> jobs-run-this  -c " " " "

3. Watch progress...check notifications.


### Run a random Docker image

1. Use the generic Docker app. See the inputs

	> jobs-template -A cloud-runner-0.1.0u3 > docker_submit.json

2. Upload your input data

  > tar czf r-demo.tgz main.r
  > files-upload -F r-demo.tgz $API_USERNAME

3. Specify your image, inputs, parameters, etc

```javascript
{
    "name": "docker r demo",
    "appId": "cloud-runner-0.1.0u3",
    "batchQueue": "debug",
    "executionSystem": "docker.iplantcollaborative.org",
    "maxRunTime": "01:00:00",
    "memoryPerNode": "1GB",
    "nodeCount": 1,
    "processorsPerNode": 1,
    "archive": false,
    "inputs": {
      "appBundle": "agave://data.iplantcollaborative.org/dooley/inputs/r-demo/r-demo.tgz"
    },
    "parameters": {
      "command": "Rscript",
      "commandArgs": "main.r",
      "dockerImage": "scivm/r-project-3.0",
      "unpackInputs": true
    },
    "notifications": [
      {
        "url":"$EMAIL_ADDRESS",
        "event":"FINISHED",
        "persistent":false
      },
      {
        "url":"$EMAIL_ADDRESS",
        "event":"FAILED",
        "persistent":false
      },
      {  "url":"http://requestbin.agaveapi.co/1cl87yo1?job=${JOB_ID}&event=${EVENT}",
      "event":"*",
      "persistent":true
      }
    ]
}

```

3. Run the job. This time it will run inside a container of the image you specified in the job request

	> jobs-submit -W -V -F docker_submit.json

3. Watch progress...check notifications.
