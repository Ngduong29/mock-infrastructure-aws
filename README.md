# Devops Mock Project
----
## Tổng quan
Dự án này tạo ra một mô hình để tự động triển khai ứng dụng lên môi trường đám mây, giúp quá trình triển khai sản phẩm nhanh chóng và hiệu quả.
Khi người dùng cập nhật ứng dụng những thay đổi sẽ được tự động cập nhật trên máy chủ.

**Công nghệ sử dụng:**
* Terraform xây dựng cơ sở hạ tầng
* Ansible cài đặt các gói tài nguyên trên EC2
* Amazcon Web Service
* Jenkins cho việc triển khai CI/CD
* Gitea để cập nhật commit và tạo webhook tới Jenkins
* DockerHub đễ lưu trữ những hình anh mà Docker xây dựng
* K8s triển khai ứng dụng
-----
## Cơ sở hạ tầng trên AWS 

![This is an alt text.](/Images/aws_infa.jpg "This is a sample image.")
-----
## Xây dựng cơ sở hạ tầng dùng Terraform
- sử dụng internal trỏ tới thư mục `terraform` và `terraform-eks`.
- Thực thi lần lượt câu lệnh:
    ```
    terraform init
    terraform plan
    terraform apply
    ```
- Khi muốn xóa tất cả cơ sở hạ tầng dùng:
    ```
    terraform destroy
    ```
-----
## Cài đặt Jenkins, Gitea sử dụng Ansible
**Ghi chú:** Lên EC2 lấy Public IPv4 DNS thay vào trong file `ansible\inventory`
- Sử dụng Ubuntu trỏ tới thư mục `ansible`
- Thực thi câu lệnh để bắt đầu chạy cài đặt:
    ```
    ansible-playbook playbook.yml
    ```
-----
## Cấu hình Jenkins và Gitea
**Gitea:**
- Tạo một repository rồi kết nối với thư mục trên máy. 
- thay thế URL trong `.git\config` bằng HTTPS của git.

**Jenkins:**
- Tạo thông tin xác thực cho Gitea và Dockerhub.
- Vào trong tập tin `Jenkinsfile` trong `application` thay đổi "DOCKER_CREDENTIALS_ID" ứng với thông tin xác thực trên Jenkins.
- Kết nối Jenkins với Gitea thông qua webhook để triển khai CI/CD.
-----
## Triển khai K8s
- SSH vào EC2 chứa Jenkins
- Sử dụng Docker để kết nối vào Jenkins bằng 
    ```
    sudo docker exec -u 0 -it jenkins-blueocean sh
    
    ```
- Cài đặt AWS CLI 
    ```
    sudo apt install awscli 
    
    ```
- Cấu hình AWS CLI
    ```
    aws configure
    
    ```
- Thực thi các lệnh để lấy tên context và cập nhật file cấu hình:
    ```
    sudo aws eks --region ap-southeast-1 update-kubeconfig --name eks_cluster
    sudo kubectl config get-contexts
    
    ```

