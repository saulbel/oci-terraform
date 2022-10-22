# terraform install
wget https://releases.hashicorp.com/terraform/1.1.3/terraform_1.1.3_linux_amd64.zip
unzip terraform_1.1.3_linux_amd64.zip
sudo mv terraform /usr/local/bin
rm terraform_1.1.3_linux_amd64.zip
terraform -v

# rsa keys creation
mkdir $HOME/.oci
openssl genrsa -out $HOME/.oci/terraform_oci.pem 2048
chmod 600 $HOME/.oci/terraform_oci.pem
openssl rsa -pubout -in $HOME/.oci/terraform_oci.pem -out $HOME/.oci/terraform_oci_public.pem
cat $HOME/.oci/terraform_oci_public.pem