# Ensure inputs.conf collects Security events
<img width="888" height="757" alt="image3" src="https://github.com/user-attachments/assets/73d770bf-84b7-4544-b170-28d5590f3229" />

# Restart UF
& "C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe" restart
<img width="1002" height="367" alt="image10" src="https://github.com/user-attachments/assets/3192142b-54ca-40a5-918e-eef31c9d4344" />

# Configure outputs.conf to forward events to Splunk server
[tcpout:group1]
server = <splunk-server-ip>:9997
<img width="865" height="179" alt="image7" src="https://github.com/user-attachments/assets/73c109ba-a71d-49f5-839b-c83c2016273e" />

I defined the destination Splunk indexer and port for log forwarding.
Completes the end-to-end pipeline, enabling your Splunk server to receive and analyze Windows login activity in real time.

