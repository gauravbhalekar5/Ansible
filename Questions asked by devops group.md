HTTP (Hypertext Transfer Protocol), HTTPD (HTTP daemon), and HTTPS (HTTP Secure) are all related to web communication protocols, but they serve different purposes.

HTTP is a protocol used to transmit data over the internet. It is the foundation of data communication on the World Wide Web. HTTP is an unencrypted protocol, which means that the data transmitted between a web browser and a web server can be intercepted and read by anyone with access to the network. It is typically used for websites that do not require secure communication, such as static websites or websites that do not handle sensitive information.

HTTPD is a program that implements the HTTP protocol. It is commonly used to describe web servers that serve HTTP requests. An HTTPD server can be used to host websites or web applications that are accessed over the internet.

HTTPS is a secure version of HTTP that uses encryption to protect data transmitted between a web browser and a web server. It uses a combination of SSL (Secure Sockets Layer) or TLS (Transport Layer Security) protocol and HTTP to encrypt and authenticate data. HTTPS is commonly used for websites that handle sensitive information such as login credentials, credit card information, or personal data. HTTPS helps prevent unauthorized access, data theft, and other malicious activities.

In summary, HTTP is a protocol for transmitting data over the internet, HTTPD is a program that implements the HTTP protocol, and HTTPS is a secure version of HTTP that uses encryption to protect data transmitted over the internet.


=========================================================================================================


If the key pair associated with an Amazon EC2 instance is lost or corrupted, it may not be possible to connect to the instance using SSH (Secure Shell). However, there are several options available to regain access to the instance:

Use another key pair: If you have another key pair that has been authorized for access to the instance, you can use it to connect to the instance.

Launch a new instance: If you do not have another key pair, you can launch a new instance and create a new key pair. You can then attach the original instance's volume to the new instance and modify the authorized keys file to include the new public key. This will enable you to access the original instance.

Use AWS Systems Manager: AWS Systems Manager is a service that can be used to manage EC2 instances. If you have enabled Systems Manager on the instance, you can use it to connect to the instance using the Session Manager feature, even if the key pair is lost or corrupted.

Create a new instance from a snapshot: If you have a recent snapshot of the instance, you can create a new instance from the snapshot and then create a new key pair for the instance. This will enable you to access the instance using the new key pair.

It is always recommended to keep a backup of the key pair in a secure location to avoid any disruption in accessing the EC2 instance.

=========================================================================================================

Difference between Declarative Pipeline and Scripted Pipeline 

Scripted Pipeline allows users to write scripts using Groovy syntax. This gives users more flexibility and control over the pipeline, as they can use any Groovy code to define the steps in the pipeline. Scripted Pipeline provides a powerful scripting environment that can be used to build complex pipelines. However, it requires a good understanding of Groovy and Jenkins, which can make it challenging for new users.

Declarative Pipeline, on the other hand, is a more structured approach that uses a declarative syntax to define the pipeline. Declarative Pipeline provides a simplified and opinionated syntax for defining pipelines, which helps to reduce errors and improve readability. This syntax is designed to be easy to read and understand, making it more accessible to new users. 


To check the CPU utilization of a specific container, you can use the docker stats command followed by the name or ID of the container.

docker stats <container_name or container_id>

The docker stats command will display real-time information about the container's resource usage, including CPU utilization, memory usage etc.

The CPU utilization is displayed as a percentage of the container's total CPU usage. It shows the amount of CPU time the container is using relative to the total available CPU time on the host system.

=========================================================================================================

COPY command is used to copy files and directories from the build context (the current directory where the Dockerfile is located) to the Docker image. It supports only basic copying of local files into the container. 

ADD command does everything that COPY does, and more. It can also retrieve files from remote URLs and extract tar files automatically into the Docker image.


