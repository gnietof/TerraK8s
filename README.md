# Terraform & Kubernetes

Because I did not have any Cloud where I could test Terraform agains, I created my own environment with four virtual machines: Terraform, Kubermetes controller and two Kubernetes worker nodes.

Once all the four VM's were configured and running. The configuration files included here were enough to start two instances of DB2 server.

Initially I just created one replica of DB2 in one of the worker nodes.

Then modified the Terraform main.tf file and when applied the second DB2 replica started in the second worker node.



## Next steps

This is just a initial step because:
1. The pods do not have persistent storage so any database contents will be lost if the pod is restarted.
1. If we create a database in one pod the other one will not be able to see the contents.
2. Even if we create a shared storage, DB2 does not allow sharing it. So we would need a much more complex configuration.
