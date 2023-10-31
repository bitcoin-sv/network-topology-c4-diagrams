# diagrams
Structurizr diagrams of the BSV network topology

# Instructions
To use Structurizer lite via Docker, run the following command by mounting a
folder location using option -v to the container location, and by mapping the
container port to a localhost port:

`docker run -v [path_to_your_local_folder]:/usr/local/structurizr -p [your_localhost_port]:8080 structurizr/lite:latest`

