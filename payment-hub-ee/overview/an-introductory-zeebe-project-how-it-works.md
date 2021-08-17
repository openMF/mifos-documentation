# An introductory Zeebe project \(How it works\)

Now that we have gotten the demo project working, let us take a closer look, at what it does, and how it works.

Below you can see the bpmn workflow that is executed. After starting, the first task is a service task. This will be handled by a Zeebe worker. Then we move on to a service task. We can identify, that the next task is a receive task, by observing the icon in the top left corner of the box, which is an envelope, as opposed to some cogwheels. 

In the event of a receive task, Zeebe will wait for some external process to complete, and confirm that the workflow can continue, by sending Zeebe a message which can be correlated to a specific instance of the workflow. Since we do not want to be waiting for this message forever, there is also a timeout event associated with this response, the icon for which is on the top right corner, of the service task box. By default, timeout is set to 1 minute, after which the workflow will return to the first task.

After sucessfully completing the receive task, we complete another service task, and then hit an exclusive gateway. This means, that the workflow process can continue on only one of the branches. We have configured a conditional branch \(one to continue on if a condition is met\), and a default branch. The default branch is marked by a small cross across it.

Finally, we have one more service task on each branch, so we can easily identify, which branch we took.

![The hello-process bpmn](../../.gitbook/assets/hello-process.png)

Now let us take a look at how this workflow is handled at a coding level.

We start the bpmn flow by calling the /start endpoint. First a variable map is created, to which the initial variables are added. These initial variables are a name \(in this demo this is 123\), and a demoKey, which is a randomly generated number, that we shall use as our correlation key in the future. We print out this demoKey, so we can compare it to the correlation key later, for ease of understanding. Then we create a new instance of the bpmn process "HelloProcess", and send it the variable map we just created. From here on the workflow has started and workers will handle the tasks in the bpmn flow. We also print out the workflow instance key. You can use this to identify the kafka messages related to a specific instance of a workflow.

```text
@GetMapping("/start")
    public void start() {
        Map<String, Object> variableMap = new HashMap<>();
        variableMap.put("name", "123");
        System.out.println(demoKey);
        variableMap.put("demoKey", demoKey);
        ProcessInstanceEvent processInstanceEvent = zeebeClient.newCreateInstanceCommand()
                .bpmnProcessId("HelloProcess")
                .latestVersion()
                .variables(variableMap)
                .send()
                .join();
        long processInstanceKey = processInstanceEvent.getProcessInstanceKey();
        LOG.info("Workflow instance created. Key: " + processInstanceKey);
    }
```

The first service task, HelloTask is handled by the worker created in the method setupHelloWorldWorker. This worker is responsible for handling all jobs, with the type hello-world. We only have one of these, the service task HelloTask. The worker first collects the variables currently associated with the workflow as a map. It then retrieves the value corresponding to the key "name", and prints out a greeting. It also creates a String message using this name, and appends this to the Map. After completing the task, it sends back the updated Map of variables, which now contains the message. You can see this both in the kafka messages sent, and on Camunda operate.

```text
    private void setupHelloWorldWorker() {
        zeebeClient.newWorker().jobType("hello-world").handler((client, job) -> {
            Map<String, Object> incomingVariables = job.getVariablesAsMap();
            LOG.info("Hello {}", incomingVariables.get("name"));
            String message = "I am a message " + incomingVariables.get("name");
            incomingVariables.put("message", message);
            client.newCompleteCommand(job.getKey())
                    .variables(incomingVariables)
                    .send();
        }).open();
    }
```

Since the next task is a receive task, Zeebe will now wait for some external process to execute. We can start this external task, by calling the /response endpoint. If the endpoint isn't called, the bpmn will circle back to it's first worker after a timeout of 1 minute.This will happen indefinitely.

```text
@GetMapping("/response")
    public void response() {
        demoResponseProcessor.response();
    }
```

This method is our "external event". It publishes a message for the receive task in the bpmn. First, it initializes a map, in which it can store variables we want to pass back to Zeebe, and adds a random integer, mapped to the key hellonumber. This will be used to decide which path to take at the exclusive gateway in the bpmn. It then publishes this message, with the randomly generated String demoKey as the correlation key. Zeebe will then use the correlation key, to identify which instance of the workflow a particular response belongs to. It does this, by comparing the value of demoKey that we send as a correlation key, to the value part of key-value pairs in the variable map of various instances, where the key is also the string "demoKey". If it finds a match, it will correlate this reponse to that instance.

After this the bpmn flow will continue, with Zeebe workers handling the necessary tasks.

```text
    public void response() {
        Map<String, Object> variables = new HashMap<>();
        int randomInt = (int) (Math.random() * 10);
        variables.put("hellonumber", randomInt);
        System.out.println(demoKey);
        zeebeClient.newPublishMessageCommand()
                .messageName("hello-message")
                .correlationKey(demoKey)
                .timeToLive(Duration.ofMillis(1000))
                .variables(variables)
                .send();
        logger.info("Successfully published response");


    }
```

The next service task HelloChecker, is handled by a worker created in the method setupHelloChecker. This worker is responsible for handling all jobs, with the type hello-checker. We only have one of these, the service task HelloChecker. The worker logs the message "Succesfully recieved response", so that we can verify, that the receive task HelloResponse received the correct response, and we have moved on with the workflow.

```text
private JobWorker setupHelloChecker() {
        return zeebeClient.newWorker().jobType("hello-checker").handler((client, job) -> {
            Map<String, Object> incomingVariables = job.getVariablesAsMap();
            LOG.info("Successfully received response");
            client.newCompleteCommand(job.getKey())
                    .variables(incomingVariables)
                    .send();
        }).open();
    }
```



After the exclusive gateway, one of two service tasks may require execution. If the workflow took the conditional branch, this will be HelloConditionWorker. This worker is responsible for handling all jobs, with the type hello-condition. We only have one of these, the service task HelloCondition. The worker first collects the variables currently associated with the workflow as a map. It then retrieves the value corresponding to the key "hellonumber", and prints it out. This is done so that we may verify, that the correct path was taken in the bpmn flow at the exclusive gateway.

```text
private void setupHelloConditionWorker() {
        zeebeClient.newWorker().jobType("hello-condition").handler((client, job) -> {
            Map<String, Object> incomingVariables = job.getVariablesAsMap();
            LOG.info("Number received {}", incomingVariables.get("hellonumber"));
            client.newCompleteCommand(job.getKey())
                    .variables(incomingVariables)
                    .send();
        }).open();
    }
```

If the default branch was taken, a very similar process executes.

```text
private void setupHelloDefaultWorker() {
        zeebeClient.newWorker().jobType("hello-default").handler((client, job) -> {
            Map<String, Object> incomingVariables = job.getVariablesAsMap();
            LOG.info("Number received {}", incomingVariables.get("hellonumber"));
            client.newCompleteCommand(job.getKey())
                    .variables(incomingVariables)
                    .send();
        }).open();
    }
```

We also have a /deploy endpoint configured. Calling the /deploy endpoint, will deploy a new version of your bpmn.

```text
@GetMapping("/deploy")
    public void deploy() {
        DeploymentEvent deployment = zeebeClient.newDeployCommand()
                .addResourceFromClasspath("hello-process.bpmn")
                .send()
                .join();

        int version = deployment.getProcesses().get(0).getVersion();

        LOG.info("Workflow deployed. Version: {}", version);
    }
```



