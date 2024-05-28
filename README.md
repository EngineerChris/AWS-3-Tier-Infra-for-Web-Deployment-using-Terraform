# 3 Tier E-commerce Architecture Deployed using terraform

This architecture supports building a scalable e-commerce platform that needs to handle varying levels of traffic based on customer demand. Here's an overview of how the architecture could be utilized:

Route 53 for DNS Resolution:
I used Amazon's Route 53 to manage and resolve domain names for the e-commerce platform. This includes mapping user-friendly domain names to the corresponding AWS resources, such as the ALB.

Front-End Servers in Auto-Scaling Group with Application Load Balancer (ALB):
The front-end servers are responsible for serving the user interface of the e-commerce website, and they are deployed within an Auto Scaling Group to automatically adjust to changes in demand.
The application Load Balancer (ALB) is used to distribute incoming traffic across multiple front-end servers, ensuring high availability and load balancing.

Public Subnets, Route Tables, and Internet Gateway for Front-End Servers:
Front-end servers are placed in public subnets, allowing them to have direct access to the internet through an Internet Gateway. This is essential for serving static assets, handling customer requests, and fetching external resources.

Web Application Servers in Auto-Scaling Group:
The web application servers, where the core business logic of the e-commerce platform resides, are also set up in an Auto Scaling Group to handle varying workloads.
These servers are connected to a Relational Database instance using security groups. The RDS instance uses the MySQL engine, providing a scalable and managed database solution.

Standby RDS MySQL Instance in Availability Zone 1b:
To enhance the availability and fault tolerance of the database, I deployed a standby RDS MySQL instance in a different availability zone (1b). This ensures that if there's a failure in one availability zone, the standby instance in the other zone can take over seamlessly by being promoted to become the master.

NAT Instances for Private App Servers:
NAT (Network Address Translation) instances are deployed in availability zones (1a and 1b) to allow private application servers in the backend to access the internet for updates and fetching packages while maintaining a secure and controlled environment.

This architecture ensures that the e-commerce platform is highly available, scalable, and resilient to failures. The combination of auto-scaling groups, load balancing, multi-AZ database deployment, and networking components allows the infrastructure to efficiently handle varying levels of traffic while providing a reliable and responsive user experience.

![image](https://github.com/Ernest41k/3-Tier-Infra-Project-Using-Terraform/assets/136405174/bf6bd8a7-a735-460f-ab5e-957e2aba1e76)




