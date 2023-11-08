# diagrams
Structurizr diagrams of the BSV network topology

# Instructions
To use Structurizer lite via Docker, run the following command by mounting a
folder location using option -v to the container location, and by mapping the
container port to a localhost port:

```
docker run -v [path_to_your_local_folder]:/usr/local/structurizr -p [your_localhost_port]:8080 structurizr/lite:latest`
```
You can add the `-d` option to run the container in the background.

---------

If you have docker compose installed, you can use:

```
docker compose up -d
```

This uses the local directory as default workspace and will host the content at [http://localhost:3030](http://localhost:3030)
