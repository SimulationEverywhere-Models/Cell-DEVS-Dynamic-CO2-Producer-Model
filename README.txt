Dynamic CO2 Producer Expation simulation was implemented and tested in Linux ubuntu terminal using the CD++ toolkit.
The following will be a description of the folder organisation, followed by step to visualize after running the simulation.

/***************************************/
Folder Organisation

README -> instructions.
Cell-Devs_Dynamic_CO2_generator.doc -> Model description, analysis, and simulation example.

Videos -> Contains videos of each simulation using the visualization tool: http://ec2-3-235-245-192.compute-1.amazonaws.com:8080/devs-viewer/app-simple/
bachelor -> Contains all simulation test cases in their individual folder with their required files
	BachelorRand10minEntrance -> simulation of dynamic CO2 generator starting in the entrance using a uniform ditribution to select the direction for 10 min.
	BachelorRand10minKitchen -> simulation of dynamic CO2 generator starting in the kitchen using a uniform ditribution to select the direction for 10 min.
	BachelorRand10minLivingRoom -> simulation of dynamic CO2 generator starting in the living room using a uniform ditribution to select the direction for 10 min.
	BachelorScheduledPath -> simulation of dynamic CO2 generator that followes a preset scheduled path for 4 minutes 
	README -> describes how to run each individual simulation
	CD++ -> CD++ toolkit DO NOT MOVE
/***************************************/
Visualization instructions

1. Run the simulation using the CD++ toolkit. Follow the README within the bachelor file for running instructions

2. Open the visualization tool on your prefered web app. Chrome is suggested. http://ec2-3-235-245-192.compute-1.amazonaws.com:8080/devs-viewer/app-simple/

3. Open the correct forlder of the simulation that was ran

4. Add the folowing files:
	- bachelor.ma 
	- bachelor.pal
	- bachelor.val
	- in.log

5. Click "Load Simulation" 

6. If the floor plan isnt present, clock on the wrench and screw driver icon; select modify grids and click apply.

7. Select play to begin visualization