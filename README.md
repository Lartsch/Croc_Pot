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
  - It is recommended to start Croc_Pot.sh script with typing in **crocpot** as this payload will collect some data off the target pc. Some of the info that it will collect will be Target pc (ip address, current user name, pc host name, ssid and passwd, mac address), This info will be used in the Croc_Pot.sh script. **NOTE** When running **crocpot** scan takes about 30-40 sec to start because of OS detection then the script will start.

# SSH MENU :

### SSH TO HAK5 GEAR
 * Ensure all hak5 gear is connected to the same local network as your keycroc
   - Recommended to setup ssh PUBLIC AND PRIVATE KEY to each of your hak5 gear, SSH to your gear Without Password
   - SSH keycroc to Bash Bunny setup, first ensure your bash bunny has internet connection and connected to the same pc as your Keycroc, (bash bunny internet setup can be found at docs.hak5.org), Croc_Pot.sh will create a payload for your bash bunny this file will be saved on your keycroc at tools/Croc_Pot/Bunny_Payload_Shell then copy this file to one of the switch on your bash bunny this is to start Reverse SSH Tunnel.

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

### Screenshot
![Screenshot from 2021-08-12 07-54-07](https://user-images.githubusercontent.com/71735542/129192585-d0933663-748a-4000-9102-6e1ceb4a851c.png)
![Screenshot from 2021-08-12 07-57-38](https://user-images.githubusercontent.com/71735542/129192913-8b880ee7-31f3-41ba-ac6b-59188e594460.png)
![Screenshot from 2021-08-12 08-00-12](https://user-images.githubusercontent.com/71735542/129193161-60bea2b4-99f5-4781-8a8c-dbd7d4b3d27f.png)
![Screenshot from 2021-08-12 08-03-59](https://user-images.githubusercontent.com/71735542/129193656-fbfcbc3c-207b-4555-be22-32a66cbe9aea.png)

