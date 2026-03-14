# Terraform & Kubernetes

Because I did not have any Cloud where I could test Terraform against, I created my own environment with four virtual machines: Terraform, Kubermetes controller and two Kubernetes worker nodes.

I installed Terraform on one virtual machine.

<img width="472" height="66" alt="Image" src="https://github.com/user-attachments/assets/01a1acc7-e03c-419e-91b7-5ee12d9d5534" />

And also created a Kubernetes cluster with the other three and managed to get them up and running.

<img width="581" height="108" alt="Image" src="https://github.com/user-attachments/assets/27944431-7077-4503-8f5b-cdc53a132ac4" />

The configuration files included here were enough to start two instances of DB2 server.

This is the output of the **terraform plan**.

<img width="800" height="463" alt="Image" src="https://github.com/user-attachments/assets/7224b549-c65e-4b1d-ba35-6804004e61ce" />

And this the final output of the **terraform apply**.

<img width="803" height="239" alt="Image" src="https://github.com/user-attachments/assets/a4bd145a-d66d-4277-aa2d-067dadfabfc1" />

I can now see that my cluster has one instance of DB2 running.

<img width="734" height="65" alt="Image" src="https://github.com/user-attachments/assets/933028d2-e8c2-42cc-a5cd-d1e22d0e102f" />

Initially I just created one replica of DB2 in one of the worker nodes. Then modified the Terraform main.tf file. The **terraform plan** shows that only the number of replicas will be increased.

When the changes finihed being applied the second DB2 replica started in the second worker node.

<img width="797" height="308" alt="Image" src="https://github.com/user-attachments/assets/1144cad6-7e19-4e1f-8ce5-c1b015b7c605" />

In the Kubernetes controller we can check that both instances are now running.

<img width="650" height="84" alt="Image" src="https://github.com/user-attachments/assets/6cb060c6-9880-46c1-bcac-e52aaa41d43f" />

## Next steps

This is just a initial step because:
1. The pods do not have persistent storage so any database contents will be lost if the pod is restarted.
1. If we create a database in one pod the other one will not be able to see the contents.
2. Even if we create a shared storage, DB2 does not allow sharing it. So we would need a much more complex configuration.
