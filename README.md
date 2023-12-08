# A simple adblocking mechanism			
Developed by Georgios Michail Siatras and Andreas Karogiannis			
TUC: Security of Systems and Services		

Proffessor: Sotirios Ioannidis			

**Usage:**	

-domains: 			

1. Read each domain name from file.			
2. Find the corresponding ip address with nslookup.		 		
3. If succesfull store to ip adresses file, otherwise store to print at the end.		
4. Operation succesfull with a list of domains we failed to get the ip.		

-ips:			

1. Read teh ips from the file.		
2. Check if ipv4 or ipv6 as iptables cant handle ipv6 addresses.	
3. Handle each type and create rules.			

-save:

1. Save ipv4 rules to file1.		
2. Save ipv6 rules to file2.		

-load:		

1. Load rules from each file.			

-list:			

1. List rules.			

-reset:			

1. Reset rules.			

-help:			

1. Display help message.			

