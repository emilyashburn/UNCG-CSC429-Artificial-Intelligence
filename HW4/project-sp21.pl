% Project - CSC429/629 Spring 2021 - Points: 10
% Due: 5:30pm April 20, 2021
% Lateness penalty: -2 per day.

% This is a 1 or 2 person assignment. Type your name(s) below:
% 1. Emily Ashburn
% 2.
% If 2 persons work on this, they only need to turn in
% one paper copy, but both of you should submit a
% duplicate copy on Canvas under each of your names.
% You may not collaborate with anyone except your partner.
% By submitting this assignment, you implicitly agree to abide
% by the UNCG Academic Integrity Policy.

% DO NOT USE THESE PROLOG FEATURES IN THIS ASSIGNMENT!! YOU
% WILL NOT RECEIVE CREDIT FOR A SOLUTION CONTAINING THESE:
% ";", "->".

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% What to turn in:
%    Submit a copy of your program on Canvas named project.txt.
%    The digital copy will be used in case the grader needs to
%    run your program to verify that it works, and to determine
%    the submission time if late.  Each student on a team should
%    submit a duplicate copy on Canvas under his/her own name.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem: For a detailed description of the project requirements
% see project-sp21-details.docx on Canvas.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit this file - add your solution to the steps below.
% Make your solution readable using indentation and white
% space. Do not use a line length that will wrap when printed.
% To run this file, rename it with a .pl extension if your are
% using SWI Prolog, or the proper extension for whatever Prolog
% you are using - you may use any standard Prolog interpreter.
% Follow these instructions for running HW5:
%   1. Copy fig15_11_mod.pl (my mod of Bratko's BN interpreter)
%      from CSC529 Canvas to your computer.
%   2. Copy fig15_7_mod_1.6.17.pl (my version of Bratko's FC rule
%      interpreter) from CSC429/629 Canvas to your computer.
%   3. Start Prolog on your project program. Before running your
%      program, tell Prolog to consult fig15_11_mod.pl and
%      fig15_7_mod_1.6.17.pl (in SWI Prolog, you would use menu
%      commands: Filemenu -> Consult -> ... )
%   4. Warning: if you run the FC rules more than once,
%      retract the facts, or just QUIT prolog and start
%      over to flush the facts from memory.

%% HW2&3 Directives (must be at top of SWI Prolog program)
%  Syntax may differ in other Prolog interpreters.
:- dynamic fact(1).
:- dynamic p/2.
:- dynamic p/3.

% Operator definitions for forward chaining if-then rules.
:- op(800,fx,if).
:- op(700,xfx,then).
:- op(300,xfy,or).
:- op(200,xfy,and).

% Step 1:  Define the BN graph using the syntax required by -------------------------------
% Bratko's BN interpreter.  Example: if there is an arc
% in the BN from node a to node b (a is the parent of b), say:
% parent(a, b).  Note: Use lower case letters for nodes!!

parent(nd, mb).
parent(nd, rr).
parent(cs, sg).
parent(es, sg).
parent(es, ls).
parent(mb, dp).
parent(rr, dp).
parent(rr, y).
parent(sg, y).
parent(sg, dl).
parent(ls, dl).



% Step 2: Define the BN prior probabilities here: ---------------------------------------

p(nd, 0.8).
p(cs, 0.35).
p(es, 0.8).

% Step 3: Define BN conditional probability tables here: --------------------------------
% Prob of Mealy Bugs
p(mb, [not(nd)], 0.15).
p(mb, [nd], 0.4).

% Prob of Root rot
p(rr, [not(nd)], 0.05).
p(rr, [nd], 0.7).

% Prob of Stunted Growth
p(sg, [not(cs), not(es)], 0.1).
p(sg, [cs, not(es)], 0.3).
p(sg, [not(cs), es], 0.6).
p(sg, [cs, es], 0.95).

% Prob of Leggy stems
p(ls, [not(es)], 0.1).
p(ls, [es], 0.98).

% Prob of Dead plant
p(dp, [not(mb), not(rr)], 0.01).
p(dp, [not(mb), rr], 0.6).
p(dp, [mb, not(rr)], 0.3).
p(dp, [mb, rr], 0.8).

% Prob of Yellow transparent leaves
p(y, [not(rr), not(sg)], 0.2).
p(y, [not(rr), sg], 0.35).
p(y, [rr, not(sg)], 0.1).
p(y, [rr, sg], 0.65).

% Prob of Dried leaves
p(dl, [not(sg), not(ls)], 0.2).
p(dl, [not(sg), ls], 0.1).
p(dl, [sg, not(ls)], 0.6).
p(dl, [sg, ls], 0.7).




% Step 4:  Define FC rules here: ------------------------------------------------

% Using cactus soil
if not(cs) then using_correct_soil.

% More than 6hrs sunlight
if not(es) then plant_gets_enough_sunlight.

% Does have drainage holes
if not(nd) then already_has_drainage_holes.

% Nothing the user did was wrong
if not(cs) and not(es) and not(nd) then if_your_plant_is_dying_then_you_did_nothing_wrong.
if if_your_plant_is_dying_then_you_did_nothing_wrong then blame_company_you_bought_plant_from.
if blame_company_you_bought_plant_from then find_receipt.
if find_receipt then take_plant_back_to_store_for_refund.
if take_plant_back_to_store_for_refund then buy_new_plant_elsewhere.

% Does not have drainage holes, has drill
if nd and use_drill then fix_drainage.
if fix_drainage then find_drill.
if find_drill then dampen_bottom_of_pot.
if dampen_bottom_of_pot then drill_hole_into_pot.

% Does not have drainage holes, doesn't have drill
if nd and not(use_drill) then make_drainage.
if make_drainage then go_to_fridge.
if go_to_fridge then drink_2liter_bottle_of_mtn_dew.
if drink_2liter_bottle_of_mtn_dew then clean_2liter_and_cut_in_half.
if clean_2liter_and_cut_in_half then poke_holes_in_bottom_half_with_scissors.
if poke_holes_in_bottom_half_with_scissors then use_as_pot.

% Not using cactus soil, has money
if cs and has_money then get_correct_soil.
if get_correct_soil then buy_cactus_soil.
if buy_cactus_soil then replace_current_soil_with_cactus_soil.
if replace_current_soil_with_cactus_soil then replant_succulent.
if replant_succulent then leave_plant_alone_for_1_week.

% Not using cactus soil, does not have money
if cs and not(has_money) then make_correct_soil.
if make_correct_soil then go_outside.
if go_outside then find_sand.
if find_sand then find_dirt.
if find_dirt then find_pebbles.
if find_pebbles then mix_together_to_make_cactus_soil.

% Less than 6hrs sunlight, has window
if es and has_window then fix_sunlight.
if fix_sunlight then find_south_facing_window.
if find_south_facing_window then relocate_plant_to_window.
if relocate_plant_to_window then make_sure_plant_gets_indirect_light.

% Less than 6hrs sunlight, does not have window
if es and not(has_window) then change_sunlight.
if change_sunlight then take_plant_outside.
if take_plant_outside then put_in_shaded_area.






% Step 5: Implement your main program here
% --------------------------------------- You will execute the program by
% calling help_system: ?-help_system. So use this as your first line:
help_system :- diagnose, fix_plan, forward.

% Implement diagnose HERE. ------------------------------------------------------
translatesoil(y, not(cs)).
translatesoil(n, cs).
translatesun(y, es).
translatesun(n, not(es)).
translatedrainage(n, nd).
translatedrainage(y, not(nd)).
translatebugs(y, mb).
translatebugs(n, not(mb)).
translaterot(y, rr).
translaterot(n, not(rr)).
translategrowth(y, sg).
translategrowth(n, not(sg)).
translatestems(y, ls).
translatestems(n, not(ls)).
translatesoil(y) :- assert(fact(not(cs))).
translatesoil(n) :- assert(fact(cs)).
translatesun(y) :- assert(fact(es)).
translatesun(n) :- assert(fact(not(es))).
translatedrainage(n) :- assert(fact(nd)).
translatedrainage(y) :- assert(fact(not(nd))).
translatebugs(y) :- assert(fact(mb)).
translatebugs(n) :- assert(fact(not(mb))).
translaterot(y) :- assert(fact(rr)).
translaterot(n) :- assert(fact(not(rr))).
translategrowth(y) :- assert(fact(sg)).
translategrowth(n) :- assert(fact(not(sg))).
translatestems(y) :- assert(fact(ls)).
translatestems(n) :- assert(fact(not(ls))).

diagnose:-
    write('Answer the following questions to help issues with your succulent.'), nl, nl,
    write('Are you using cactus soil? (y or n): '),
    read(Soil),
    translatesoil(Soil, X), translatesoil(Soil), nl,
    write('Is the succulent getting less than 6hrs indirect sunlight? (y or n): '),
    read(Sun),
    translatesun(Sun, Y), translatesun(Sun), nl,
    write('Does the pot have drainage holes? (y or n): '),
    read(Drain),
    translatedrainage(Drain, Z), translatedrainage(Drain), nl,
    write('Are there mealy bugs on your plant? (y or n): '),
    read(Bugs),
    translatebugs(Bugs, A), translatebugs(Bugs), nl,
    write('Check the root system of your plant. Does it have root rot? (y or n): '),
    read(Rot),
    translaterot(Rot, B), translaterot(Rot), nl,
    write('Has it been a long time since the plant grew? (y or n): '),
    read(Grew),
    translategrowth(Grew, C), translategrowth(Grew), nl,
    write('Are the stems reeeaallllly long? (y or n): '),
    read(Long),
    translatestems(Long, D), translatestems(Long), nl,
    write('The probability of a dead plant is: '),
    prob(dp, [X, Y, Z, A, B, C, D], Pdeadplant), write(Pdeadplant), nl,
    write('The probability of yellow transparent leaves is: '),
    prob(y, [X, Y, Z, A, B, C, D], Pyellowtransparentleaves), write(Pyellowtransparentleaves), nl,
    write('The probability of dried leaves is: '),
    prob(dl, [X, Y, Z, A, B, C, D], Pdriedleaves), write(Pdriedleaves), nl,
    find_cause(Pdeadplant, Pyellowtransparentleaves, Pdriedleaves).


find_cause(Pdeadplant,Pyellowtransparentleaves,Pdriedleaves):-
    Pdeadplant > Pyellowtransparentleaves,
    Pdeadplant > Pdriedleaves,
    write('The most probable outcome is a deadplant.'), nl.
find_cause(Pdeadplant, Pyellowtransparentleaves,Pdriedleaves):-
    Pyellowtransparentleaves > Pdeadplant,
    Pyellowtransparentleaves > Pdriedleaves,
    write('The most probable outcome is yellow transparent leaves.'), nl.
find_cause(Pdeadplant, Pyellowtransparentleaves,Pdriedleaves):-
    Pdriedleaves > Pyellowtransparentleaves,
    Pdriedleaves > Pdeadplant,
    write('The most probable outcome is dried leaves'), nl.
find_cause(Pdeadplant, Pyellowtransparentleaves,Pdriedleaves):-
    Pyellowtransparentleaves == Pdeadplant,
    Pyellowtransparentleaves == Pdriedleaves,
    write('All outcomes are likely'), nl.
% Implement fix_plan HERE. -----------------------------------------------------

translatewindow(y) :- assert(fact(has_window)).
translatewindow(n) :- assert(fact(not(has_window))).
translatemoney(y) :- assert(fact(has_money)).
translatemoney(n) :- assert(fact(not(has_money))).
translatedrill(y) :- assert(fact(use_drill)).
translatedrill(n) :- assert(fact(not(use_drill))).

fix_plan:-
    write('Do you have a south facing window at your location? (y or n): '),
    read(Window), translatewindow(Window), nl,
    write('Do you have like $15 to get new soil? (y or n) :'),
    read(Money), translatemoney(Money), nl,
    write('Do you have an electric drill? (y or n) :'),
    read(Drill), translatedrill(Drill), nl.


