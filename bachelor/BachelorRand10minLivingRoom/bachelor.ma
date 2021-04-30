[top]
components : bachelor

[bachelor]
type : cell

% Each cell is 25cm x 25cm x 25cm = 15.626 Liters of air each
dim : (21,30)
%dim : (44, 40)

delay : transport
defaultDelayTime : 1000
border : nonwrapped

neighbors :           bachelor(0,-1)
neighbors : bachelor(-1,0)  Bachelor1(0,0)  bachelor(1,0) 
neighbors :           bachelor(0,1)

%  Background indoor CO2 levels assumed to be 500 ppm
initialvalue : 500
localtransition : rules 

% 3 State Variables corresponding to CO2 concentraion in ppm (conc) and the kind of cell (type)
% Default CO2 concentration inside a building (conc) is 0.05% or 500ppm in normal air
StateVariables: conc type counter direction
NeighborPorts: c ty co dir
StateValues: 500 -100 -1 0
InitialVariablesValue: bachelor.val

% STATE VARIABLE LEGEND :
%   conc = double : represents the CO2 concentration (units of ppm) in a given cell, can be any positive numbe, default value is 500ppm
%
%   type = -100 : normal cell representing air with some CO2 concentration
%   type = -200 : CO2 source, constantly emits a specific CO2 output
%   type = -300 : impermeable structure (ie: walls, chairs, tables, solid objects)
%   type = -400 : doors, fixed at normal indoor background co2 level (500 ppm)
%   type = -500 : window, fixed at lower co2 levels found outside (400 ppm)
%   type = -600 : ventillation, actively removing CO2 (300 ppm)
%   type = -700 : WindowLocation (500 ppm)

[rules]
% type -200 rules


%make sure co2 doesnt go in a wall
rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} {$counter := $counter + 1; $direction := 60;} 1000 { ($type = -200 AND (-1, 0)~ty = -300) AND NOT($counter = 2 OR $counter = 5)}

rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} {$counter := $counter + 1; $direction := 40;} 1000 { ($type = -200 AND (1,0)~ty = -300) AND NOT($counter = 2 OR $counter = 5)}

rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} {$counter := $counter + 1; $direction := 20;} 1000 { ($type = -200 AND (0,-1)~ty = -300) AND NOT($counter = 2 OR $counter = 5)}

rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} {$counter := $counter + 1; $direction := 80;} 1000 { ($type = -200 AND (0,1)~ty = -300) AND NOT($counter = 2 OR $counter = 5)}

% CO2 sources have their concentration continually increased by 12.16 ppm every 5 seconds. Normal diffusion rule applies.
rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} {$counter := $counter + 1; } 1000 { $type = -200 AND NOT($counter = 2 OR $counter = 5)}

rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} { $conc := ((121.6*2) + (((-1,0)~c + (0,-1)~c + (0,0)~c + (0,1)~c + (1,0)~c)/5)); $counter := 0; } 1000 { ($type = -200 AND $counter = 5)}

%co2 generator -> empty space
rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} { $type:= -100; $conc := ((121.6*2) + (((-1,0)~c + (0,-1)~c + (0,0)~c + (0,1)~c + (1,0)~c)/5)); $counter:= $counter + 1;} 1000 { ($type = -200 AND $counter = 2)}



% type -100 rules

% CO2 sources movement
%Walk right
rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} { $type:= -200; $counter:= (-1,0)~co + 1; $direction:= randInt(100);} 1000 { ($type = -100 AND (-1,0)~ty = -200) AND (((-1,0)~dir > 50 AND (-1,0)~dir <= 75) AND (-1,0)~co = 2)}

%walk left
rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} { $type:= -200; $counter:= (1,0)~co + 1; $direction:= randInt(100);} 1000 { ($type = -100 AND (1,0)~ty = -200) AND (((1,0)~dir > 25 AND (1,0)~dir <= 50) AND (1,0)~co = 2)}

%walk down
rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} { $type:= -200; $counter:= (0,-1)~co + 1; $direction:= randInt(100);} 1000 { ($type = -100 AND (0,-1)~ty = -200) AND ((0,-1)~dir <= 25 AND (0,-1)~co = 2)}

%walk up
rule : { ~c := $conc; ~ty := $type; ~co := $counter; ~dir := $direction;} { $type:= -200; $counter:= (0,1)~co + 1; $direction:= randInt(100);} 1000 { ($type = -100 AND (0,1)~ty = -200) AND ((0,1)~dir > 75 AND (0,1)~co = 2 )}


% Diffusion between normal air cells 
rule : { ~c := $conc; ~ty := $type; ~co := $counter;} { $conc := (((-1,0)~c + (0,-1)~c + (0,0)~c + (0,1)~c + (1,0)~c)/5); } 1000 { $type = -100 AND (-1,0)~c > 0 AND (0,-1)~c > 0 AND (0,1)~c > 0 AND (1,0)~c > 0}
rule : { ~c := $conc; ~ty := $type; ~co := $counter;} { $conc := (((0,-1)~c + (0,0)~c + (0,1)~c + (1,0)~c)/4); } 1000 { $type = -100 AND (-1,0)~c < 0 AND (0,-1)~c > 0 AND (0,1)~c > 0 AND (1,0)~c > 0}
rule : { ~c := $conc; ~ty := $type; ~co := $counter;} { $conc := (((-1,0)~c + (0,0)~c + (0,1)~c + (1,0)~c)/4); } 1000 { $type = -100 AND (-1,0)~c > 0 AND (0,-1)~c < 0 AND (0,1)~c > 0 AND (1,0)~c > 0}
rule : { ~c := $conc; ~ty := $type; ~co := $counter;} { $conc := (((-1,0)~c + (0,-1)~c + (0,0)~c + (1,0)~c)/4); } 1000 { $type = -100 AND (-1,0)~c > 0 AND (0,-1)~c > 0 AND (0,1)~c < 0 AND (1,0)~c > 0}
rule : { ~c := $conc; ~ty := $type; ~co := $counter;} { $conc := (((-1,0)~c + (0,-1)~c + (0,0)~c + (0,1)~c)/4); } 1000 { $type = -100 AND (-1,0)~c > 0 AND (0,-1)~c > 0 AND (0,1)~c > 0 AND (1,0)~c < 0}
rule : { ~c := $conc; ~ty := $type; ~co := $counter;} { $conc := (((0,0)~c + (0,1)~c + (1,0)~c)/3); } 1000 { $type = -100 AND (-1,0)~c < 0 AND (0,-1)~c < 0 AND (0,1)~c > 0 AND (1,0)~c > 0}
rule : { ~c := $conc; ~ty := $type; ~co := $counter;} { $conc := (((-1,0)~c + (0,-1)~c + (0,0)~c)/3); } 1000 { $type = -100 AND (-1,0)~c > 0 AND (0,-1)~c > 0 AND (0,1)~c < 0 AND (1,0)~c < 0}
rule : { ~c := $conc; ~ty := $type; ~co := $counter;} { $conc := (((0,-1)~c + (0,0)~c + (1,0)~c)/3); } 1000 { $type = -100 AND (-1,0)~c < 0 AND (0,-1)~c > 0 AND (0,1)~c < 0 AND (1,0)~c > 0}
rule : { ~c := $conc; ~ty := $type; ~co := $counter;} { $conc := (((-1,0)~c + (0,0)~c + (0,1)~c)/3); } 1000 { $type = -100 AND (-1,0)~c > 0 AND (0,-1)~c < 0 AND (0,1)~c > 0 AND (1,0)~c < 0}




% type -300 rules
% No diffusion / CO2 concentration for impermeable structures
rule : { ~c := $conc; ~ty := $type; } { $conc := -10; } 1000 { $type = -300 }

% type -400 rules
% Doors represent fixed co2 levels of the rest of the building (large volume compared to small room)
rule : { ~c := $conc; ~ty := $type; } { $conc := 500; } 1000 { $type = -400 }

% type -500 rules
% Windows to the outside have a lower CO2 concentration (anywhere from 300 to 400 ppm)
rule : { ~c := $conc; ~ty := $type; } { $conc := 400; } 1000 { $type = -500 }

% type -600 rules
% Ventilation actively removes CO2 at a rate greater than doors or windows. (assumed equivalent to 300 ppm)
rule : { ~c := $conc; ~ty := $type; } { $conc := 300; } 1000 { $type = -600 }



% Default rule: keep concentration the same if all other rules untrue (should never happen)
rule : { ~c := $conc; ~ty := $type; } { $counter := $counter +1; } 1000 { t }

