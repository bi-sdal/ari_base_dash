# Army Research Institute Base Characteristics Dashboard

An example of the running application can be found here:

- https://aerogers.shinyapps.io/ari_base_dash/
- https://chendaniely.shinyapps.io/ari_base_dash/

# Developer's Notes

Since this project is on both gitlab and github please set the remotes such that a push command is automatically pushed into 2 locations

Assuming your SSH keys are setup for both services you can run the below code and any push will be pushed to both locations

```
git remote set-url --add --push origin git@devlab.vbi.vt.edu:sdal/ari_base_dash.git
git remote set-url --add --push origin git@github.com:bi-sdal/ari_base_dash.git
```
