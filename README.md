# Trade-Tariff running on CloudFoundry



### Installing the CLI

Interacting with Cloud Foundry is easiest through the cf command line interface.
To install it please follow [this](https://documentation.trial.cf.paas.alphagov.co.uk/getting-started/setup/) instructions.

### Log in with your account

    cf login -a api.trial.cf.paas.alphagov.co.uk

### Target organization and space

The Cloud Foundry CLI keeps a global state of whatever organization+space you’re interacting with. This is known as the “target”.

To set the target to the `tradetariff.gov.uk` organization and the `dev` space:

    cf target -o tradetariff.gov.uk -s dev

## Deploying

You deploy the application to Cloud Foundry by running a push command from a Cloud Foundry command line interface (CLI).

You can define deployment options on the command line, in a manifest file, or both together.

Cloud Foundry uploads all application files except version control files with file extensions .svn, .git, and .darcs. To exclude other files from upload, specify them in the `.cfignore` file.

### Set Environment Variables

You should set the enviroment variables before the deploy in order to avoid issues of missing keys.

    cf set-env APP_NAME ENV_NAME ENV_VALUE


### Pushing the Application

Run the following command to deploy an application without a manifest file:

    cf push APP-NAME

If you provide the application name in a manifest file, you can reduce the command to `cf push`, the command cf push locates the `manifest.yml` in the current working directory by default, if your manifest is located elsewhere or has a different name, use the `-f` option to provide the path to the filename.

    cf push -f /other-path/other-name.yml

### Configure Service Connections

If may need to define a service to bound to the application that you deployed, for example services like postgresql or redis are available, the way to add them is with the `create-service` option:

for example `postgresql94`:

    cf create-service postgresql94 free DESIRED-SERVICE-NAME

And we can bind the new service created to our app:

    cf bind-service APP-NAME DESIRED-SERVICE-NAME

### Tailing Logs

Stream Loggregator output to the terminal:

    cf logs APP_NAME
    
### Getting DB dump

https://docs.cloud.service.gov.uk/#creating-tcp-tunnels-with-ssh
    
